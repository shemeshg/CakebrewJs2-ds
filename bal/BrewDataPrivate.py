from property import Prpt, PrptClass, EnumClass


ary = []
p = Prpt("QString",'brewLocation')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QString",'normalFontPointSize')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QString",'terminalApp')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("bool",'updateForce')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)

p = Prpt("int",'x')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("int",'y')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("int",'width')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("int",'height')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)

p = Prpt("bool",'isExtendedCask')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("bool",'isExtendedFormula')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("bool",'isExtendedService')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("bool",'isShowBrewInfoText')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)

p = Prpt("QVector<SearchResultRow *>",'searchItemsCask')
p.is_bindable = False
p.is_writable = False
p.is_notify = True
p.is_getter_ref = True
ary.append(p)
p = Prpt("QVector<SearchResultRow *>",'searchItemsFormula')
p.is_bindable = False
p.is_writable = False
p.is_notify = True
p.is_getter_ref = True
ary.append(p)
p = Prpt("QString",'searchStatusCaskText')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QString",'searchStatusFormulaText')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("bool",'searchStatusCaskVisible')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("bool",'searchStatusFormulaVisible')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("bool",'searchCaskRunning')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("bool",'searchFormulaRunning')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QString",'refreshStatusCaskText')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QString",'refreshStatusFormulaText')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QString",'refreshStatusServiceText')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("bool",'refreshStatusServiceVisible')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("bool",'refreshStatusFormulaVisible')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("bool",'refreshStatusCaskVisible')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("bool",'refreshServiceRunning')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("bool",'refreshFormulaRunning')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("bool",'refreshCaskRunning')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("int",'serviceSortedColIdx')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("int",'serviceSortedColOrder')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("int",'caskSortedColIdx')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("int",'caskSortedColOrder')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("int",'formulaSortedColIdx')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("int",'formulaSortedColOrder')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QVariantList",'formulaTableBodyList')
p.is_bindable = False
p.is_writable = False
p.is_notify = True
p.is_getter_ref = True
ary.append(p)
p = Prpt("QVariantList",'caskTableBodyList')
p.is_bindable = False
p.is_writable = False
p.is_notify = True
p.is_getter_ref = True
ary.append(p)
p = Prpt("QVariantList",'serviceTableBodyList')
p.is_bindable = False
p.is_writable = False
p.is_notify = True
p.is_getter_ref = True
ary.append(p)
p = Prpt("InfoStatus",'infoStatus')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QString",'infoToken')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)

for txt in ["isInfoShowPin","isInfoShowUnpin","isInfoShowUpgrade","isInfoShowInstall",
"isInfoShowUninstall","isInfoShowUninstallZap"]:
        p = Prpt("bool",txt)
        p.is_bindable = False
        p.is_writable = True
        p.is_notify = True
        ary.append(p)




enumClasss = []
e = EnumClass("InfoStatus",
        ["Idile",
        "Running",
        "CaskFound",
        "FormulaFound",
        "CaskNotFound",
        "FormulaNotFound"])
enumClasss.append(e)

classBrewDataPrivate = PrptClass("BrewDataPrivate", ary, enumClasss)
classBrewDataPrivate.inhirit_from = "JsAsync"


