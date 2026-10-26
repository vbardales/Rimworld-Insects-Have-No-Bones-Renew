using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace InsectsHaveNoBonesRenew.PickleSteps
{
    /// <summary>
    /// The two props of the gallery story that no shared tool provides: a carcass lying on the ground, and the
    /// products of a butchering laid out one per cell. Both generate a fresh adult of a pawn kind, as ButcherSteps
    /// does, so what the picture shows is what the patched game hands out.
    /// </summary>
    [PickleSteps]
    public class GallerySteps
    {
        private static Pawn FreshAdult(PickleContext ctx, string kindName)
        {
            PawnKindDef kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindName);
            ctx.Assert(kind != null, "no PawnKindDef is named '" + kindName + "': the mod that adds it is not loaded");
            Pawn animal = PawnGenerator.GeneratePawn(kind, null);
            List<LifeStageAge> stages = animal.RaceProps.lifeStageAges;
            if (stages != null && stages.Count > 0)
            {
                animal.ageTracker.AgeBiologicalTicks = (long)(stages[stages.Count - 1].minAge * 3600000f);
            }
            return animal;
        }

        [Given("Insects Have No Bones Renew: a dead adult {string} lies at \\({int}, {int}\\)")]
        public void DeadAdultLiesAt(PickleContext ctx, string kindName, int x, int z)
        {
            Map map = Find.CurrentMap;
            ctx.Assert(map != null, "there is no current map: load a save first");
            IntVec3 cell = new IntVec3(x, 0, z);
            ctx.Assert(cell.InBounds(map) && cell.Standable(map), "the cell (" + x + ", " + z + ") is not free to stand on");
            Pawn animal = FreshAdult(ctx, kindName);
            GenSpawn.Spawn(animal, cell, map);
            animal.Kill(null);
            ctx.Assert(animal.Corpse != null && animal.Corpse.Spawned, kindName + " left no corpse on the map");
        }

        [Given("Insects Have No Bones Renew: the butcher products of a fresh adult {string} lie in a row from \\({int}, {int}\\)")]
        public void ProductsLieInARow(PickleContext ctx, string kindName, int x, int z)
        {
            Map map = Find.CurrentMap;
            ctx.Assert(map != null, "there is no current map: load a save first");
            Pawn butcher = map.mapPawns.FreeColonists.FirstOrDefault();
            ctx.Assert(butcher != null, "the loaded map has no free colonist to do the butchering");
            Pawn animal = FreshAdult(ctx, kindName);
            try
            {
                List<Thing> products = animal.ButcherProducts(butcher, 1f).ToList();
                ctx.Assert(products.Count > 0, kindName + " yielded nothing");
                for (int i = 0; i < products.Count; i++)
                {
                    IntVec3 cell = new IntVec3(x + i, 0, z);
                    ctx.Assert(cell.InBounds(map), "the row runs off the map at (" + cell.x + ", " + cell.z + ")");
                    GenSpawn.Spawn(products[i], cell, map);
                }
            }
            finally
            {
                animal.Discard(true);
            }
        }
    }
}
