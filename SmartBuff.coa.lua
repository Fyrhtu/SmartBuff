-------------------------------------------------------------------------------
-- Conquest of Azeroth (CoA) support for SmartBuff
-- Ascension Area 52 / CoA: 21 custom classes, shapeshift specs, and HERO buff
-- profile (combined all-class buff list for CoA heroes).
-------------------------------------------------------------------------------

SMARTBUFF_COA_CLASSES = {
  NECROMANCER     = true,
  PYROMANCER      = true,
  CULTIST         = true,
  STARCALLER      = true,
  SUNCLERIC       = true,
  TINKER          = true,
  RUNEMASTER      = true,
  PRIMALIST       = true,
  REAPER          = true,
  VENOMANCER      = true,
  CHRONOMANCER    = true,
  SONOFARUGAL     = true,
  GUARDIAN        = true,
  STORMBRINGER    = true,
  FELSWORN        = true,
  BARBARIAN       = true,
  WITCHDOCTOR     = true,
  WITCHHUNTER     = true,
  KNIGHTOFXOROTH  = true,
  TEMPLAR         = true,
  RANGER          = true,
  HERO            = true,
};

SMARTBUFF_COA_CLASS_ALIASES = {
  SONOFARUGAL     = "SONOFARUGAL",
  SONARUGAL       = "SONOFARUGAL",
  SUNCLERIC       = "SUNCLERIC",
  SUNOFCLERIC     = "SUNCLERIC",
  WITCHDOCTOR     = "WITCHDOCTOR",
  WITCHHUNTER     = "WITCHHUNTER",
  KNIGHTOFXOROTH  = "KNIGHTOFXOROTH",
  KNIGHTXOROTH    = "KNIGHTOFXOROTH",
};

SMARTBUFF_COA_SHAPESHIFT_CLASSES = {
  DRUID           = true,
  SHAMAN          = true,
  HERO            = true,
  SONOFARUGAL     = true,
  PRIMALIST       = true,
  BARBARIAN       = true,
  REAPER          = true,
  FELSWORN        = true,
  RANGER          = true,
  VENOMANCER      = true,
  GUARDIAN        = true,
  WARRIOR         = true,
  PRIEST          = true,
  DEATHKNIGHT     = true,
  PALADIN         = true,
  ROGUE           = true,
};

SMARTBUFF_COA_CLASS_MAP = {
  NECROMANCER     = "WARLOCK",
  PYROMANCER      = "MAGE",
  CULTIST         = "WARLOCK",
  STARCALLER      = "MAGE",
  SUNCLERIC       = "PRIEST",
  TINKER          = "HUNTER",
  RUNEMASTER      = "WARRIOR",
  PRIMALIST       = "SHAMAN",
  REAPER          = "ROGUE",
  VENOMANCER      = "ROGUE",
  CHRONOMANCER    = "MAGE",
  SONOFARUGAL     = "DRUID",
  GUARDIAN        = "WARRIOR",
  STORMBRINGER    = "SHAMAN",
  FELSWORN        = "WARLOCK",
  BARBARIAN       = "WARRIOR",
  WITCHDOCTOR     = "PRIEST",
  WITCHHUNTER     = "HUNTER",
  KNIGHTOFXOROTH  = "PALADIN",
  TEMPLAR         = "PALADIN",
  RANGER          = "HUNTER",
};

SMARTBUFF_COA_FORM_SPELL_NAMES = {
  "Cat Form",
  "Bear Form",
  "Dire Bear Form",
  "Moonkin Form",
  "Tree of Life",
  "Travel Form",
  "Aquatic Form",
  "Flight Form",
  "Swift Flight Form",
  "Ghost Wolf",
  "Shadowform",
  "Worgen Form",
  "Feral Form",
  "Human Form",
  "Metamorphosis",
  "Demon Form",
  "Blood Presence",
  "Frost Presence",
  "Unholy Presence",
  "Battle Stance",
  "Defensive Stance",
  "Berserker Stance",
  "Stealth",
  "Prowl",
  "Fang Form",
};

SMARTBUFF_COA_BUFFABLE_FORM_NAMES = {
  "Tree of Life",
  "Shadowform",
  "Human Form",
  "Devotion Aura",
  "Retribution Aura",
  "Concentration Aura",
  "Shadow Resistance Aura",
  "Frost Resistance Aura",
  "Fire Resistance Aura",
  "Sanctity Aura",
  "Crusader Aura",
  "Blood Aura",
  "Frost Aura",
  "Unholy Aura",
  "Blood Presence",
  "Frost Presence",
  "Unholy Presence",
};

SMARTBUFF_COA_BUFFABLE_FORMS = {};
SMARTBUFF_COA_FORM_SPELLS = {};
SMARTBUFF_COA_FORM_ONLY_BUFFS = {};

function SMARTBUFF_NormalizeClassToken(classToken)
  if (classToken == nil) then
    return nil;
  end
  local token = string.upper(string.gsub(classToken, "[%s%-_']", ""));
  if (SMARTBUFF_COA_CLASS_ALIASES[token]) then
    return SMARTBUFF_COA_CLASS_ALIASES[token];
  end
  return token;
end

function SMARTBUFF_IsCoAClass(classToken)
  local token = SMARTBUFF_NormalizeClassToken(classToken);
  if (token == nil) then
    return false;
  end
  return SMARTBUFF_COA_CLASSES[token] == true;
end

function SMARTBUFF_IsCoAShapeshiftClass(classToken)
  local token = SMARTBUFF_NormalizeClassToken(classToken);
  if (token == nil) then
    return false;
  end
  return SMARTBUFF_COA_SHAPESHIFT_CLASSES[token] == true;
end

function SMARTBUFF_IsVanillaClass(classToken)
  local token = SMARTBUFF_NormalizeClassToken(classToken);
  if (token == nil) then
    return false;
  end
  return token == "DRUID" or token == "HUNTER" or token == "MAGE" or token == "PALADIN"
    or token == "PRIEST" or token == "ROGUE" or token == "SHAMAN" or token == "WARLOCK"
    or token == "WARRIOR" or token == "DEATHKNIGHT";
end

function SMARTBUFF_ResolvePlayerClass(classToken)
  local token = SMARTBUFF_NormalizeClassToken(classToken);
  if (token == nil) then
    return "HERO";
  end
  if (token == "HERO" or SMARTBUFF_IsCoAClass(token)) then
    return token;
  end
  if (SMARTBUFF_IsVanillaClass(token)) then
    return token;
  end
  return token;
end

function SMARTBUFF_GetBuffListClass(classToken)
  local token = SMARTBUFF_ResolvePlayerClass(classToken);
  if (token == "HERO" or token == "VENOMANCER") then
    return token;
  end
  if (SMARTBUFF_IsCoAClass(token)) then
    return SMARTBUFF_COA_CLASS_MAP[token] or "HERO";
  end
  return token;
end

function SMARTBUFF_GetBuffTargetClass(classToken)
  local token = SMARTBUFF_NormalizeClassToken(classToken);
  if (token == nil) then
    return classToken;
  end
  return SMARTBUFF_COA_CLASS_MAP[token] or token;
end

function SMARTBUFF_IsDruidLikeClass(classToken)
  local token = SMARTBUFF_NormalizeClassToken(classToken);
  if (token == nil) then
    return false;
  end
  return token == "DRUID" or SMARTBUFF_COA_CLASS_MAP[token] == "DRUID";
end

function SMARTBUFF_IsBuffClassEnabled(buffSettings, classToken)
  if (buffSettings == nil or classToken == nil) then
    return false;
  end
  local token = SMARTBUFF_NormalizeClassToken(classToken);
  if (buffSettings[token]) then
    return true;
  end
  local mapped = SMARTBUFF_GetBuffTargetClass(token);
  if (mapped ~= token and buffSettings[mapped]) then
    return true;
  end
  return false;
end

function SMARTBUFF_IsGroupBuffTarget(buffSettings, classToken, creatureType)
  if (buffSettings == nil or classToken == nil) then
    return false;
  end
  if (SMARTBUFF_IsBuffClassEnabled(buffSettings, classToken)) then
    return true;
  end
  local token = SMARTBUFF_NormalizeClassToken(classToken);
  if (SMARTBUFF_IsCoAProfile() and creatureType == SMARTBUFF_HUMANOID and SMARTBUFF_IsCoAClass(token)) then
    return SMARTBUFF_GetBuffTargetClass(token) ~= nil;
  end
  return false;
end

function SMARTBUFF_IsHeroProfile()
  return sPlayerClass == "HERO";
end

function SMARTBUFF_IsCoAProfile()
  return SMARTBUFF_IsCoAClass(sPlayerClass) or sPlayerClass == "HERO";
end

SMARTBUFF_COA_CLASS_BUFF_DEFS = {
  VENOMANCER = {
    {names = {"Blight Venom"},                               duration = 0.5,  buffType = SMARTBUFF_CONST_SELF},
    {names = {"Venom Coat", "Envenom"},                      duration = 0.5,  buffType = SMARTBUFF_CONST_SELF},
    {names = {"Toxic Frenzy", "Toxic Skin"},                 duration = 0.25, buffType = SMARTBUFF_CONST_SELF},
    {names = {"Fang Form"},                                  duration = -1,   buffType = SMARTBUFF_CONST_SELF},
    {names = {"Deadly Venom"},                               duration = 1,    buffType = SMARTBUFF_CONST_WEAPON},
    {names = {"Necrotic Venom", "Crippling Venom"},          duration = 1,    buffType = SMARTBUFF_CONST_WEAPON},
  },
  STORMBRINGER = {
    {names = {"Call of the Storm"},                          duration = 30,   buffType = SMARTBUFF_CONST_GROUP, exclude = "ROGUE;WARRIOR;DEATHKNIGHT;HPET;WPET;DKPET", selfNot = true},
    {names = {"Whirlwind Aegis"},                            duration = 30,   buffType = SMARTBUFF_CONST_SELF},
  },
};

function SMARTBUFF_RegisterBuffableForm(formName)
  if (formName and formName ~= "") then
    SMARTBUFF_COA_BUFFABLE_FORMS[string.lower(formName)] = true;
  end
end

function SMARTBUFF_CoA_ResolveSpellByNames(names)
  if (names == nil) then
    return nil;
  end
  local _, name;
  for _, name in ipairs(names) do
    if (name and SMARTBUFF_GetSpellID(name) ~= nil) then
      return name;
    end
  end
  return nil;
end

function SMARTBUFF_CoA_BuildBuffEntry(def)
  if (def == nil or def.names == nil) then
    return nil;
  end
  local spell = SMARTBUFF_CoA_ResolveSpellByNames(def.names);
  if (spell == nil) then
    return nil;
  end
  return {
    spell,
    def.duration,
    def.buffType,
    def.levels,
    def.exclude,
    def.group,
    def.gduration,
    def.glevels,
    def.reagents,
    def.selfNot,
  };
end

function SMARTBUFF_CoA_MergePatterns(basePatterns, extraPatterns)
  local merged = {};
  local pat;
  if (basePatterns ~= nil) then
    for _, pat in ipairs(basePatterns) do
      table.insert(merged, pat);
    end
  end
  if (extraPatterns ~= nil) then
    for _, pat in ipairs(extraPatterns) do
      table.insert(merged, pat);
    end
  end
  if (table.getn(merged) == 0) then
    return nil;
  end
  return merged;
end

function SMARTBUFF_CoA_AppendClassBuffs(buffList, classToken)
  if (buffList == nil) then
    return buffList;
  end
  local token = SMARTBUFF_NormalizeClassToken(classToken);
  local defs = SMARTBUFF_COA_CLASS_BUFF_DEFS[token];
  if (defs == nil) then
    return buffList;
  end
  local entry;
  for _, def in ipairs(defs) do
    entry = SMARTBUFF_CoA_BuildBuffEntry(def);
    if (entry ~= nil) then
      table.insert(buffList, entry);
    end
  end
  return buffList;
end

function SMARTBUFF_CoA_InitClassSpells()
  SMARTBUFF_BLIGHTVENOM   = SMARTBUFF_CoA_ResolveSpellByNames({"Blight Venom"});
  SMARTBUFF_VENOMCOAT    = SMARTBUFF_CoA_ResolveSpellByNames({"Venom Coat", "Envenom"});
  SMARTBUFF_TOXICFRENZY  = SMARTBUFF_CoA_ResolveSpellByNames({"Toxic Frenzy", "Toxic Skin"});
  SMARTBUFF_FANGFORM     = SMARTBUFF_CoA_ResolveSpellByNames({"Fang Form"});
  SMARTBUFF_DEADLYVENOM  = SMARTBUFF_CoA_ResolveSpellByNames({"Deadly Venom"});
  SMARTBUFF_NECROTICVENOM = SMARTBUFF_CoA_ResolveSpellByNames({"Necrotic Venom", "Crippling Venom"});
  SMARTBUFF_CALLOFTHESTORM = SMARTBUFF_CoA_ResolveSpellByNames({"Call of the Storm"});
  SMARTBUFF_WHIRLWINDAEGIS = SMARTBUFF_CoA_ResolveSpellByNames({"Whirlwind Aegis"});

  if (SMARTBUFF_FANGFORM) then
    SMARTBUFF_RegisterBuffableForm(SMARTBUFF_FANGFORM);
  end
end

function SMARTBUFF_CoA_IsVenomBuff(buffName)
  if (buffName == nil) then
    return false;
  end
  local lower = string.lower(buffName);
  return string.find(lower, "venom", 1, true) ~= nil
    or string.find(lower, "blight", 1, true) ~= nil
    or string.find(lower, "toxin", 1, true) ~= nil;
end

function SMARTBUFF_CoA_CheckLinkedVenomBuff(buffR, buff, tl)
  if (buffR == nil or buff == nil) then
    return false, tl;
  end
  if (not SMARTBUFF_CoA_IsVenomBuff(buffR) or not SMARTBUFF_CoA_IsVenomBuff(buff)) then
    return false, tl;
  end
  if (SMARTBUFF_BuffNamesMatch(buffR, buff)) then
    return true, tl;
  end
  if (SMARTBUFF_BLIGHTVENOM and (SMARTBUFF_BuffNamesMatch(buffR, SMARTBUFF_BLIGHTVENOM) or SMARTBUFF_BuffNamesMatch(buff, SMARTBUFF_BLIGHTVENOM))) then
    if (string.find(string.lower(buff), "blight", 1, true) or string.find(string.lower(buffR), "blight", 1, true)) then
      return true, tl;
    end
  end
  local rootR = string.match(string.lower(buffR), "([%a%s]+)");
  local rootB = string.match(string.lower(buff), "([%a%s]+)");
  if (rootR and rootB and string.find(rootB, rootR, 1, true)) then
    if (tl == nil or tl <= 0) then
      tl = 1800;
    end
    return true, tl;
  end
  return false, tl;
end

function SMARTBUFF_CoA_InitFormSpells()
  SMARTBUFF_COA_FORM_SPELLS = {};
  SMARTBUFF_COA_FORM_ONLY_BUFFS = {};

  local _, name, resolved;
  for _, name in ipairs(SMARTBUFF_COA_FORM_SPELL_NAMES) do
    resolved = SMARTBUFF_CoA_ResolveSpellByNames({name});
    if (resolved) then
      SMARTBUFF_COA_FORM_SPELLS[string.lower(resolved)] = resolved;
    end
  end

  SMARTBUFF_COA_WORGEN_FORM = SMARTBUFF_CoA_ResolveSpellByNames({"Worgen Form", "Feral Form"});
  SMARTBUFF_COA_FERAL_FORM   = SMARTBUFF_CoA_ResolveSpellByNames({"Feral Form", "Worgen Form"});
  SMARTBUFF_COA_BEAR_FORM    = SMARTBUFF_CoA_ResolveSpellByNames({"Bear Form", "Dire Bear Form"});
  SMARTBUFF_COA_CAT_FORM     = SMARTBUFF_CoA_ResolveSpellByNames({"Cat Form"});
  SMARTBUFF_COA_GHOST_WOLF   = SMARTBUFF_CoA_ResolveSpellByNames({"Ghost Wolf"});

  if (SMARTBUFF_COA_CAT_FORM == nil) then
    SMARTBUFF_COA_CAT_FORM = SMARTBUFF_DRUID_CAT;
  end
  if (SMARTBUFF_COA_GHOST_WOLF == nil) then
    SMARTBUFF_COA_GHOST_WOLF = "Ghost Wolf";
  end
end

function SMARTBUFF_CoA_InitBuffableForms()
  SMARTBUFF_COA_BUFFABLE_FORMS = {};

  local _, formName;
  for _, formName in ipairs(SMARTBUFF_COA_BUFFABLE_FORM_NAMES) do
    SMARTBUFF_RegisterBuffableForm(formName);
  end

  SMARTBUFF_RegisterBuffableForm(SMARTBUFF_DRUID_TREE);
  SMARTBUFF_RegisterBuffableForm(SMARTBUFF_SHADOWFORM);
  SMARTBUFF_RegisterBuffableForm(SMARTBUFF_BLOODPRESENCE);
  SMARTBUFF_RegisterBuffableForm(SMARTBUFF_FROSTPRESENCE);
  SMARTBUFF_RegisterBuffableForm(SMARTBUFF_UNHOLYPRESENCE);
  SMARTBUFF_RegisterBuffableForm(SMARTBUFF_DEVOTIONAURA);
  SMARTBUFF_RegisterBuffableForm(SMARTBUFF_RETRIBUTIONAURA);
  SMARTBUFF_RegisterBuffableForm(SMARTBUFF_CONCENTRATIONAURA);
  SMARTBUFF_RegisterBuffableForm(SMARTBUFF_SHADOWRESISTANCEAURA);
  SMARTBUFF_RegisterBuffableForm(SMARTBUFF_FROSTRESISTANCEAURA);
  SMARTBUFF_RegisterBuffableForm(SMARTBUFF_FIRERESISTANCEAURA);
  SMARTBUFF_RegisterBuffableForm(SMARTBUFF_SANCTITYAURA);
  SMARTBUFF_RegisterBuffableForm(SMARTBUFF_CRUSADERAURA);
  SMARTBUFF_RegisterBuffableForm(SMARTBUFF_BLOODAURA);
  SMARTBUFF_RegisterBuffableForm(SMARTBUFF_FROSTAURA);
  SMARTBUFF_RegisterBuffableForm(SMARTBUFF_UNHOLYAURA);
end

function SMARTBUFF_IsBuffableForm(formName)
  if (formName == nil or formName == "") then
    return false;
  end
  return SMARTBUFF_COA_BUFFABLE_FORMS[string.lower(formName)] == true;
end

function SMARTBUFF_IsClassExcludeList(exclude)
  return exclude ~= nil and exclude ~= "x" and string.find(exclude, ";") ~= nil;
end

function SMARTBUFF_IsFormOnlyExclude(exclude)
  if (exclude == nil or exclude == "x" or SMARTBUFF_IsClassExcludeList(exclude)) then
    return false;
  end
  return true;
end

function SMARTBUFF_IsFormNameMatch(left, right)
  if (left == nil or right == nil) then
    return false;
  end
  if (left == right) then
    return true;
  end
  return string.lower(left) == string.lower(right);
end

function SMARTBUFF_AreFormsEquivalent(left, right)
  if (SMARTBUFF_IsFormNameMatch(left, right)) then
    return true;
  end
  if (SMARTBUFF_DRUID_CAT and (SMARTBUFF_IsFormNameMatch(left, SMARTBUFF_DRUID_CAT) or SMARTBUFF_IsFormNameMatch(right, SMARTBUFF_DRUID_CAT))) then
    if (SMARTBUFF_COA_CAT_FORM and (SMARTBUFF_IsFormNameMatch(left, SMARTBUFF_COA_CAT_FORM) or SMARTBUFF_IsFormNameMatch(right, SMARTBUFF_COA_CAT_FORM))) then
      return true;
    end
  end
  if (SMARTBUFF_COA_WORGEN_FORM and (SMARTBUFF_IsFormNameMatch(left, SMARTBUFF_COA_WORGEN_FORM) or SMARTBUFF_IsFormNameMatch(right, SMARTBUFF_COA_WORGEN_FORM))) then
    if (SMARTBUFF_COA_FERAL_FORM and (SMARTBUFF_IsFormNameMatch(left, SMARTBUFF_COA_FERAL_FORM) or SMARTBUFF_IsFormNameMatch(right, SMARTBUFF_COA_FERAL_FORM))) then
      return true;
    end
    if (SMARTBUFF_COA_CAT_FORM and (SMARTBUFF_IsFormNameMatch(left, SMARTBUFF_COA_CAT_FORM) or SMARTBUFF_IsFormNameMatch(right, SMARTBUFF_COA_CAT_FORM))) then
      return true;
    end
  end
  return false;
end

function SMARTBUFF_ExcludeAllowsForm(exclude, formName)
  if (exclude == nil or formName == nil) then
    return false;
  end
  if (SMARTBUFF_AreFormsEquivalent(exclude, formName)) then
    return true;
  end
  if (string.find(string.lower(exclude), string.lower(formName), 1, true)) then
    return true;
  end
  return false;
end

function SMARTBUFF_CanCastBuffForForm(exclude, isShapeshifted, formName, inShapeshiftOpt, mode)
  if (SMARTBUFF_IsFormOnlyExclude(exclude)) then
    if (not isShapeshifted) then
      return false;
    end
    return SMARTBUFF_ExcludeAllowsForm(exclude, formName);
  end

  if (isShapeshifted and not inShapeshiftOpt) then
    if (SMARTBUFF_ExcludeAllowsForm(exclude, formName)) then
      return true;
    end
    if (mode == 1) then
      return true;
    end
    return false;
  end

  return true;
end

function SMARTBUFF_BuffNamesMatch(expected, actual)
  if (expected == nil or actual == nil) then
    return false;
  end
  if (expected == actual) then
    return true;
  end
  local e = string.lower(expected);
  local a = string.lower(actual);
  if (e == a) then
    return true;
  end
  if (string.find(a, e, 1, true) or string.find(e, a, 1, true)) then
    return true;
  end
  return false;
end

function SMARTBUFF_CoA_GetActiveShapeshift()
  local i;
  local activeForm = GetShapeshiftForm(true);
  if (activeForm and activeForm > 0) then
    local _, name = GetShapeshiftFormInfo(activeForm);
    if (name and not SMARTBUFF_IsBuffableForm(name)) then
      return true, name;
    end
  end

  for i = 1, GetNumShapeshiftForms(), 1 do
    local _, name, active = GetShapeshiftFormInfo(i);
    if (active == 1 and name and not SMARTBUFF_IsBuffableForm(name)) then
      if (sPlayerClass == "DRUID" and SMARTBUFF_GetSpellID(name) == nil) then
        -- ignore inactive druid form buttons
      else
        return true, name;
      end
    end
  end

  return false, nil;
end

function SMARTBUFF_IsPlayerDruidLike()
  return SMARTBUFF_IsDruidLikeClass(sPlayerClass);
end