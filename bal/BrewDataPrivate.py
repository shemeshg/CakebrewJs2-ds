from property import Prpt, PrptClass


ary = []
p = Prpt("QString",'lastUpdateDateStr')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QVector<GridCell *>",'caskBodyList')
p.is_bindable = False
p.is_writable = False
p.is_notify = True
p.is_getter_ref = True
ary.append(p)
p = Prpt("QVector<GridCell *>",'formulaBodyList')
p.is_bindable = False
p.is_writable = False
p.is_notify = True
p.is_getter_ref = True
ary.append(p)
p = Prpt("QVector<GridCell *>",'servicesBodyList')
p.is_bindable = False
p.is_writable = False
p.is_notify = True
p.is_getter_ref = True
ary.append(p)
p = Prpt("QString",'brewLocation')
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


classBrewDataPrivate = PrptClass("BrewDataPrivate", ary)
classBrewDataPrivate.inhirit_from = "JsAsync"
        

