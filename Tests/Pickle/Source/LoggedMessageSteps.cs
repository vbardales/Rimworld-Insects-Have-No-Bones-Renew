using System;
using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using Verse;

namespace InsectsHaveNoBonesRenew.PickleSteps
{
    /// <summary>
    /// The one thing Pickle's own steps cannot say about this mod's declared incompatibility, and it is about the log.
    ///
    /// Pickle's "no errors were logged" reads the errors recorded since the scenario was armed, and arming clears the
    /// buffer, so every error the game logged while it LOADED THE DEFS is gone before the first step runs. The
    /// original mod's defect is logged exactly then. Those lines are still in RimWorld's own in-memory log,
    /// Verse.Log.Messages, so this step reads that instead. Its limit is the log's own: it keeps a bounded number of
    /// recent messages, so a long modlist could push an early line out. The pass that uses it stages a small set.
    ///
    /// The text starts with "Insects Have No Bones Renew:" and uses no parentheses or slashes: see ButcherSteps.
    /// </summary>
    [PickleSteps]
    public class LoggedMessageSteps
    {
        private static string FirstLine(string text)
        {
            int cut = text.IndexOf('\n');
            return cut < 0 ? text : text.Substring(0, cut);
        }

        /// <summary>
        /// Passes when something logged as an error or a warning contains the given text, ignoring case. It is here
        /// for the declared incompatibility: the original mod still names a class Medieval Overhaul renamed, and the
        /// game logs that when it reads the original's patches next to this mod.
        /// </summary>
        [Then("Insects Have No Bones Renew: an error or a warning was logged naming {string}")]
        public void SomethingNames(PickleContext ctx, string text)
        {
            List<string> all = Log.Messages
                .Where(m => m.type == LogMessageType.Error || m.type == LogMessageType.Warning)
                .Select(m => m.text ?? string.Empty)
                .ToList();
            ctx.Assert(
                all.Any(line => line.IndexOf(text, StringComparison.OrdinalIgnoreCase) >= 0),
                "expected an error or a warning naming '" + text + "'; the log holds " + all.Count + " of them: "
                + string.Join(" | ", all.Take(5).Select(FirstLine)));
        }
    }
}
