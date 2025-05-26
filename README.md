# finite_prod_techs
Factorio mod for finite productivity technologies

Reads the theoretical maximum level of each recipe productivity technology
that would have an effect and sets that as a hard maximum for said technology.
This takes into account machine built-in prod if the recipes can only be
crafted in specific machines, the set maximum productivity for each
recipe (default is 300%, but mods can set higher limits), and the rate
that the technology increases the productivity (all vanilla prod techs
are 10%, though mods can have other ammounts). It does not take into
account a single recipe being affected by multiple technologies. Any
affects that mods can have to existing prod techs should be accounted for.

This was not done in vanilla Space Age due to the Tech Maniac achievement,
though this mod can be safely added after obtaining it.
