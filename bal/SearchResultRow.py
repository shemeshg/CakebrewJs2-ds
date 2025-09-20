from property import Prpt, PrptClass


ary = []
p = Prpt("QString",'token')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QString",'name')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QString",'version')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QString",'homepage')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QString",'desc')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("bool",'installed')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)

classSearchResultRow = PrptClass("SearchResultRow", ary,[])



