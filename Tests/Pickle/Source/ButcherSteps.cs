using System;
using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace InsectsHaveNoBonesRenew.PickleSteps
{
    /// <summary>
    /// The one observation this mod's XML tests cannot make: what the game actually hands out when an animal
    /// is butchered, after every patch has been applied and every Def has inherited from its abstract base.
    ///
    /// The step generates a fresh adult of a pawn kind and asks the game for its butcher products, exactly as
    /// the butchering job does (Pawn.ButcherProducts, which Medieval Overhaul and Outland Core both patch), then
    /// keeps the list for the assertions that follow. Nothing is spawned and nothing is left behind: the animal
    /// is discarded at the end of the step.
    ///
    /// Every step text starts with "Insects Have No Bones Renew:". Pickle loads the steps of every active suite
    /// into one namespace, and two suites declaring the same text make healthy scenarios fail with "Ambiguous
    /// step". No text here uses parentheses or slashes, which Cucumber expressions read as optional text and
    /// alternatives.
    ///
    /// What "bone" and "fat" mean here. Medieval Overhaul's are the defs DankPyon_Bone and DankPyon_Fat. Outland
    /// Core's bone is another def whose name was not read (its Workshop folder was absent when this was written),
    /// so a bone is any product whose defName contains "Bone". That is deliberately broad on the side that matters:
    /// it can only make "holds no bone" harder to pass, never easier, and the control scenarios assert that a
    /// muffalo and a cow DO yield one in the same pass, so a name this test does not recognise fails there first.
    /// </summary>
    [PickleSteps]
    public class ButcherSteps
    {
        private const string MedievalOverhaulFat = "DankPyon_Fat";

        private class ButcherResult
        {
            public string Kind;
            public List<Thing> Products;

            public string Describe()
            {
                return Products.Count == 0
                    ? "nothing"
                    : string.Join(", ", Products.Select(p => p.def.defName + " x" + p.stackCount));
            }
        }

        private static bool IsBone(Thing thing)
        {
            return thing.def.defName.IndexOf("Bone", StringComparison.OrdinalIgnoreCase) >= 0;
        }

        private static bool IsFat(Thing thing)
        {
            return thing.def.defName == MedievalOverhaulFat;
        }

        private static bool IsMeat(Thing thing)
        {
            return thing.def.IsMeat;
        }

        /// <summary>
        /// Generates a fresh adult of the pawn kind and butchers it once, at full efficiency, by the first free
        /// colonist of the loaded map. Needs a loaded save: the products depend on the butcher's stats and on the
        /// game being up, so this is not played from the main menu.
        /// </summary>
        [When("Insects Have No Bones Renew: I butcher a fresh adult {string}")]
        public void ButcherFreshAdult(PickleContext ctx, string kindName)
        {
            PawnKindDef kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindName);
            ctx.Assert(kind != null, "no PawnKindDef is named '" + kindName + "': the mod that adds it is not loaded, or the name changed");

            Map map = Find.CurrentMap;
            ctx.Assert(map != null, "there is no current map: load a save before butchering");

            Pawn butcher = map.mapPawns.FreeColonists.FirstOrDefault();
            ctx.Assert(butcher != null, "the loaded map has no free colonist to do the butchering");

            Pawn animal = PawnGenerator.GeneratePawn(kind, null);
            try
            {
                List<LifeStageAge> stages = animal.RaceProps.lifeStageAges;
                if (stages != null && stages.Count > 0)
                {
                    animal.ageTracker.AgeBiologicalTicks = (long)(stages[stages.Count - 1].minAge * 3600000f);
                }

                List<Thing> products = animal.ButcherProducts(butcher, 1f).ToList();
                ctx.Set(new ButcherResult { Kind = kindName, Products = products });
            }
            finally
            {
                animal.Discard(true);
            }
        }

        [Then("Insects Have No Bones Renew: the butcher products hold meat")]
        public void HoldMeat(PickleContext ctx)
        {
            ButcherResult result = ctx.Get<ButcherResult>();
            ctx.Assert(
                result.Products.Any(IsMeat),
                result.Kind + " yielded no meat, so this scenario cannot tell whether a bone was suppressed or never produced; it yielded " + result.Describe());
        }

        [Then("Insects Have No Bones Renew: the butcher products hold no bone")]
        public void HoldNoBone(PickleContext ctx)
        {
            ButcherResult result = ctx.Get<ButcherResult>();
            List<Thing> bones = result.Products.Where(IsBone).ToList();
            ctx.Assert(
                bones.Count == 0,
                result.Kind + " yielded a bone (" + string.Join(", ", bones.Select(p => p.def.defName + " x" + p.stackCount)) + "); all products: " + result.Describe());
        }

        [Then("Insects Have No Bones Renew: the butcher products hold a bone")]
        public void HoldBone(PickleContext ctx)
        {
            ButcherResult result = ctx.Get<ButcherResult>();
            ctx.Assert(
                result.Products.Any(IsBone),
                result.Kind + " yielded no bone: either the bone mod under test does not produce one for it, or its bone is not named with 'Bone'; all products: " + result.Describe());
        }

        [Then("Insects Have No Bones Renew: the butcher products hold fat")]
        public void HoldFat(PickleContext ctx)
        {
            ButcherResult result = ctx.Get<ButcherResult>();
            ctx.Assert(
                result.Products.Any(IsFat),
                result.Kind + " yielded no " + MedievalOverhaulFat + "; all products: " + result.Describe());
        }

        [Then("Insects Have No Bones Renew: the butcher products hold no fat")]
        public void HoldNoFat(PickleContext ctx)
        {
            ButcherResult result = ctx.Get<ButcherResult>();
            ctx.Assert(
                !result.Products.Any(IsFat),
                result.Kind + " yielded " + MedievalOverhaulFat + "; all products: " + result.Describe());
        }
    }
}
