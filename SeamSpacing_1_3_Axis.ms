rollout SeamSpacing "SeamSpacing" width:150 height:370
(
	pickbutton btn1 "Pick Shape" pos:[25,10] width:100 height:30 toolTip:"Select shape"
	checkbox chk2 "Create capsule seam?" pos:[20,50] width:100 height:40
	pickbutton btn2 "Pick Seam" pos:[25,90] width:100 height:30 toolTip:"Select seam object"
	spinner spn2 "Spacing" pos:[25,130] width:100 height:16 range:[0,1000,0] 
	checkbox chk6 "Rename shape?" pos:[25,155] width:100 height:20	
	edittext edt1 "" pos:[25,180] width:100 height:20 enabled:false text: "Shape name"
	checkbox chk1 "Delete Anim Keys?" pos:[25,205] width:100 height:40
	button btn3 "Spacing" pos:[25,235] width:100 height:30 toolTip:"Lets go!"
	label lbl1 "" pos:[15,272] width:130 height:40
	GroupBox grp2 "Layers Name:" pos:[0,270] width:150 height:45
	-----------------------------------------------------------------------------------------
	GroupBox grp1 "Seams_Axis:" pos:[0,320] width:150 height:45
	radiobuttons x_rdo "" pos:[10,340] width:30 height:16 labels:#("X") enabled:true default:1
	radiobuttons y_rdo "" pos:[40,340] width:30 height:16 labels:#("Y") enabled:true default:0
	radiobuttons z_rdo "" pos:[70,340] width:30 height:16 labels:#("Z") enabled:true default:0
	checkbox fl_chk "Flip" pos:[100,340] width:40 height:16 checked:false enabled:true

	on btn1 picked obj do --Picking Shape
	(
		btn1.text=obj.name
		convertToSplineShape obj
		edt1.text=obj.name
		lbl1.text=lbl1.text+"\n"+btn1.text+"_shape"
		)
	on chk2 changed state do
	(
	capsule_seam=Capsule radius:0.025 height:0.25 heighttype:0 sides:6 heightsegs:1 pos:[0,0,0] name:"Capsule_" 	
	CenterPivot capsule_seam
	btn2.object=capsule_seam
	btn2.text=btn2.object.name	
	lbl1.text=lbl1.text+"\n"+btn1.text+"_seams"
	)		
	on btn2 picked obj do --Picking Seam
	(
		btn2.text=obj.name
		lbl1.text=lbl1.text+"\n"+btn2.text+"_seams"
		CenterPivot obj
		)
	on chk6 changed state do --Check box Rename shape
		if chk6.state==true then edt1.enabled =true else edt1.enabled =false

	on edt1 entered txt do --Renaming shape
		(
		txt=btn1.object.name	
		lbl1.text="Layers Name:"	
		lbl1.text=lbl1.text+"\n"+txt+"_shape"+"\n"+txt+"_seams"
		select btn1.object
		btn1.text=txt	
		clearSelection()
		)
	on x_rdo changed stat do
		(
		y_rdo.state=0
		z_rdo.state=0
		layer= LayerManager.getLayerFromName  (btn1.text+"_seams")
		if layer!=undefined do
		(
		layer.nodes &theSeames
		for i in theSeames do
		(
		select i	
		$.pos.controller.axis = 0
		)
		)
		)
	on y_rdo changed stat do
		(
		x_rdo.state=0
		z_rdo.state=0
		layer= LayerManager.getLayerFromName  (btn1.text+"_seams")
		if layer!=undefined do
		(	
		layer.nodes &theSeames
		for i in theSeames do
		(
		select i	
		$.pos.controller.axis = 1
		)
		)
		)
	on z_rdo changed stat do
		(
		x_rdo.state=0
		y_rdo.state=0	
		layer= LayerManager.getLayerFromName  (btn1.text+"_seams")
		if layer!=undefined do
		(	
		layer.nodes &theSeames
		for i in theSeames do
		(
		select i	
		$.pos.controller.axis = 2
		)
		)	
		)
	on fl_chk changed state do
		(
		layer= LayerManager.getLayerFromName  (btn1.text+"_seams")
		if layer!=undefined do
		(	
		layer.nodes &theSeames			
		if fl_chk.state==true then
		(
		for i in theSeames do
		(
		select i	
		$.pos.controller.axisFlip = on
		)			
		)
		else
		(
		for i in theSeames do
		(
		select i	
		$.pos.controller.axisFlip = off
		)				
		)
		)
	)	
		
	on btn3 pressed do -- Spacing along spline with Path constrain
	(
		if spn2.value !=0 and btn1.text!="Pick Shape" and btn2.text!="Pick Seam" then
		(
			if x_rdo.state<1 then
			(
				if y_rdo.state<1 then seam_axis = 2 
				else seam_axis = 1
			)
			else seam_axis = 0
			spl=btn1.object
			----------------------------------------------------------------------------------
			--start if shape has one spline 
			if (numSplines spl)==1 then
			(
			shape_a=getSegLengths btn1.object 1 cum:true byVertex:true numArcSteps: 100
			Spl_length=shape_a[shape_a.count]
			Seam_count=Spl_length/spn2.value
			Seam_countF=(Seam_count-(Seam_count as integer))-0.5
			if Seam_countF>=0 do Seam_count+=1
			seam_perc_inc=100.0/(Seam_count as integer)
			arr=#()
			layer= layermanager.newLayerFromName  (btn1.text+"_seams")
			layer= LayerManager.getLayerFromName  (btn1.text+"_seams")
			for i=1 to i=Seam_count do
			(
			pc = Path_Constraint ()	
			select btn2.object
			perc=(i-1)*seam_perc_inc 
			maxOps.cloneNodes $ cloneType:#instance newNodes:&nnl
			select nnl
			$.pos.controller = pc
			pc.path = btn1.object 
			$.pos.controller.follow = on
			$.pos.controller.allowUpsideDown = on
			$.pos.controller.axis = seam_axis				
			$.pos.controller.percent = perc
			layer.addNode $
			append arr $	
			clearSelection()
			)
			lbl1.text="Layers Name:"
			select arr	
			if chk1.state==true do deleteKeys $ #allKeys
			)
			--end if shape has one spline 
			--------------------------------------------------------------------------------
			else
			(
			--------------------------------------------------------------------------------	
			--start detaching splines from multispline shape
			shap_layer= layermanager.newLayerFromName  (spl.name+"_shapes")
			shap_layer= LayerManager.getLayerFromName  (spl.name+"_shapes")
			for s = 1 to (numSplines spl) do
			(
			maxOps.cloneNodes spl cloneType:#copy newNodes:&spl_nnl
			select spl_nnl
			shap_layer.addNode $
			if s!=1 do (setFirstSpline spl_nnl s)
			for n=2 to (numSplines spl) do
			(		
				for k = 1 to (numKnots $ n) do
				(deleteKnot $ n 1	)
			)
			)
			select spl	
			spl_layer= layermanager.newLayerFromName  (spl.name+"_OldShape")
			spl_layer= LayerManager.getLayerFromName  (spl.name+"_OldShape")
			spl_layer.addNode $	
			spl_layer.ishidden=true
			--updateshape shapes
			--end detaching splines from multispline shape
			----------------------------------------------------------------
			----------------------------------------------------------------
			--start cycle for seaming splines detached from multispline shape
			shap_layer.nodes &theSplines
			for g=1 to theSplines.count do
			(
			shape_a=getSegLengths theSplines[g] 1 cum:true byVertex:true numArcSteps: 100
			Spl_length=shape_a[shape_a.count]
			Seam_count=Spl_length/spn2.value
			Seam_countF=(Seam_count-(Seam_count as integer))-0.5
			if Seam_countF>=0 do Seam_count+=1
			seam_perc_inc=100.0/(Seam_count as integer)
			arr=#()
			layer= layermanager.newLayerFromName  (btn1.text+"_seams")
			layer= LayerManager.getLayerFromName  (btn1.text+"_seams")
			for i=1 to i=Seam_count do
			(
			select btn2.object
			pc = Path_Constraint ()
			perc=(i-1)*seam_perc_inc 
			maxOps.cloneNodes $ cloneType:#instance newNodes:&nnl
			select nnl
			$.pos.controller = pc
			pc.path = theSplines[g] 
			$.pos.controller.follow = on
			$.pos.controller.allowUpsideDown = on	
			$.pos.controller.axis = seam_axis	
			$.pos.controller.percent = perc
			layer.addNode $
			append arr $	
			clearSelection()
			)
			lbl1.text="Layers Name:"	
			select arr	
			if chk1.state==true do deleteKeys $ #allKeys
			)
			--end cycle for seaming splines detached from multispline shape
			--------------------------------------------------------------------------
			)
		)		
		else messagebox "Pick objects and select spacing distance!"
	)
	
)
CreateDialog SeamSpacing