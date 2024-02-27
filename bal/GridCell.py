from property import Prpt, PrptClass


ary = []
p = Prpt("QString",'cellType')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QString",'cellText')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("bool",'fillWidth')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QString",'filterString')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QString",'onToggled')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)
p = Prpt("QString",'hoverText')
p.is_bindable = False
p.is_writable = True
p.is_notify = True
ary.append(p)

classGridCell = PrptClass("GridCell", ary)

        

