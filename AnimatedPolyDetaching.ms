animationRange=interval -30 ($.faces.count*2+20)
--$.constrainType = 0
for i=1 to $.faces.count do
(
$.EditablePoly.setSelection #Face #{i}
$.EditablePoly.detachToElement #Face keepOriginal:off
at time (i-30) animate on ($.constrainType = 3;move $.selectedfaces [0,0,1])
at time i animate on ($.constrainType = 0;move $.selectedfaces [0,0,50])
at time ($.faces.count+20) animate on ($.constrainType = 3;move $.selectedfaces [0,0,-1])	
at time ($.faces.count*2-i+20) animate on ($.constrainType = 0;move $.selectedfaces [0,0,-50])	
)	