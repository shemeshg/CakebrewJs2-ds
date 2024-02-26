from property import Prpt, PrptClass


ary = []
p = Prpt("bool",'isDesigner')
p.is_bindable = False
p.is_writable = False
p.is_notify = False
ary.append(p)
classBrewData = PrptClass("BrewDataPrivate", ary)
classBrewData.inhirit_from = "JsAsync"
        

