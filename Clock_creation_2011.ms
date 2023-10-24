rollout Clock_Rollout "Set time" width:168 height:294
(
	GroupBox grp_st "Start time" pos:[5,5] width:160 height:45
	GroupBox grp_dur "Duration" pos:[5,55] width:160 height:45
	GroupBox grp_et "End time" pos:[5,128] width:160 height:45
	label lbl_fpm "FPM" pos:[65,180] width:47 height:16
	button btn_reset "Reset" pos:[32,224] width:100 height:25
	button btn_create "Create" pos:[32,259] width:100 height:25
	spinner spn_st_hrs "Hrs" pos:[20,25] width:60 height:16 range:[0,23,0] type:#integer
	spinner spn_st_min "Min" pos:[95,25] width:60 height:16 range:[0,59,0] type:#integer
	spinner spn_dur_hrs "Hrs" pos:[20,70] width:60 height:16 range:[0,72,0] type:#integer
	spinner spn_dur_min "Min" pos:[95,70] width:60 height:16 range:[0,59,1] type:#integer
	spinner spn_et_hrs "Hrs" pos:[20,141] width:60 height:16 range:[0,23,0] enabled:false type:#integer
	spinner spn_et_min "Min" pos:[95,141] width:60 height:16 range:[0,59,1] enabled:false type:#integer
	spinner spn_fpm "" pos:[48,200] width:60 height:16 range:[2,100,2] type:#integer
	checkbox chk_et "Enter end time" pos:[16,104] width:120 height:24
-------------------------------------------------------------------------------------------------------	
--Opening Clock_Rollout
-------------------------------------------------------------------------------------------------------
on Clock_Rollout open do (
-------------------------------------------------------------------------------------------------------	
--Material creation
-------------------------------------------------------------------------------------------------------
meditMaterials[1] = Multimaterial name: "Black_White" numsubs: 2
meditMaterials[1].materialList = #(VRayMtl name:"Black", VRayMtl name:"White")
meditMaterials[1].material[1].Diffuse = color 0 0 0
meditMaterials[1].names[1] = "Black"
meditMaterials[1].material[2].Diffuse = color 255 255 255
meditMaterials[1].names[2] = "White"
-------------------------------------------------------------------------------------------------------	
--Clock_back object creation
-------------------------------------------------------------------------------------------------------
Box name: "Clock_back" position: [0,0,-1] lengthsegs:1 widthsegs:1 heightsegs:1 length:45 width:105 height:1 mapcoords:on material: meditMaterials[1] 
-------------------------------------------------------------------------------------------------------	
--Main object creation
-------------------------------------------------------------------------------------------------------
Box name: "Hrs_01_01" lengthsegs:2 widthsegs:1 heightsegs:2 length:4 width:11 height:1 mapcoords:on material: meditMaterials[1]
select $Hrs_01_01
move $Hrs_01_01 [-39,16,0.5]
$.parent = $Clock_back
macros.run "Modifier Stack" "Convert_to_Poly"
subobjectLevel = 4
$.EditablePoly.SetSelection #Face #{1..16}
move  $.selectedFaces [0,0,-0.5]
$.autoSmoothThreshold = 0
$.EditablePoly.autosmooth ()
$.EditablePoly.setSmoothingGroups 0 1 1
$.EditablePoly.SetSelection #Face #{1..16}
$.EditablePoly.setMaterialIndex 1 1
$.EditablePoly.SetSelection #Face #{1,2, 5, 7,8, 11, 13,14}
$.EditablePoly.setMaterialIndex  2 1
subobjectLevel = 1
$.EditablePoly.SetSelection #Vertex #{4, 10, 15}
move $.selectedVerts [2,0,0]
$.EditablePoly.SetSelection #Vertex #{3, 9, 18}
move $.selectedVerts [-2,0,0]
subobjectLevel = 0
-------------------------------------------------------------------------------------------------------	
--Sec object creation
-------------------------------------------------------------------------------------------------------
Box name: "Sec01" lengthsegs:2 widthsegs:1 heightsegs:2 length:4 width:2 height:1 mapcoords:on material: meditMaterials[1]
select $Sec01
$.parent = $Clock_back
macros.run "Modifier Stack" "Convert_to_Poly"
subobjectLevel = 4
$.EditablePoly.SetSelection #Face #{1..16}
move  $.selectedFaces [0,0,-0.5]
$.autoSmoothThreshold = 0
$.EditablePoly.autosmooth ()
$.EditablePoly.setSmoothingGroups 0 1 1
$.EditablePoly.SetSelection #Face #{1..16}
$.EditablePoly.setMaterialIndex 1 1
$.EditablePoly.SetSelection #Face #{1,2, 5, 7,8, 11, 13,14}
$.EditablePoly.setMaterialIndex  2 1
subobjectLevel = 1
$.EditablePoly.SetSelection #Vertex #{4, 10, 15}
move $.selectedVerts [2,0,0]
$.EditablePoly.SetSelection #Vertex #{3, 9, 18}
move $.selectedVerts [-2,0,0]
subobjectLevel = 0
in coordsys local $Sec01.rotation=(eulerAngles 0 0 90)
move $Sec01 [0,8,0.5]
instance $Sec01 name: "Sec02" position:[0,-8,0.5]
-------------------------------------------------------------------------------------------------------	
--Hours instances creation
-------------------------------------------------------------------------------------------------------
instance $Hrs_01_01 name: "Hrs_01_02" position:[0,0,0]
in coordsys local $Hrs_01_02.rotation=(eulerAngles 0 0 90)
move $Hrs_01_02 [-46.9,8,0.5]
instance $Hrs_01_02 name: "Hrs_01_03" position:[-31,8,0.5]
instance $Hrs_01_01 name: "Hrs_01_04" position:[-39,0,0.5]
instance $Hrs_01_02 name: "Hrs_01_05" position:[-46.9,-8,0.5]
instance $Hrs_01_02 name: "Hrs_01_06" position:[-31,-8,0.5]
instance $Hrs_01_01 name: "Hrs_01_07" position:[-39,-16,0.5]
instance $Hrs_01_01 name: "Hrs_02_01" position:[-15.5,16,0.5]
instance $Hrs_01_02 name: "Hrs_02_02" position:[-23.5,8,0.5]
instance $Hrs_01_02 name: "Hrs_02_03" position:[-7.5,8,0.5]
instance $Hrs_01_01 name: "Hrs_02_04" position:[-15.5,0,0.5]
instance $Hrs_01_02 name: "Hrs_02_05" position:[-23.5,-8,0.5]
instance $Hrs_01_02 name: "Hrs_02_06" position:[-7.5,-8,0.5]
instance $Hrs_01_01 name: "Hrs_02_07" position:[-15.5,-16,0.5]
instance $Hrs_01_01 name: "Min_01_01" position:[15.5,16,0.5]
instance $Hrs_01_02 name: "Min_01_02" position:[7.5,8,0.5]
instance $Hrs_01_02 name: "Min_01_03" position:[23.5,8,0.5]
instance $Hrs_01_01 name: "Min_01_04" position:[15.5,0,0.5]
instance $Hrs_01_02 name: "Min_01_05" position:[7.5,-8,0.5]
instance $Hrs_01_02 name: "Min_01_06" position:[23.5,-8,0.5]
instance $Hrs_01_01 name: "Min_01_07" position:[15.5,-16,0.5]
instance $Hrs_01_01 name: "Min_02_01" position:[39,16,0.5]
instance $Hrs_01_02 name: "Min_02_02" position:[31,8,0.5]
instance $Hrs_01_02 name: "Min_02_03" position:[46.9,8,0.5]
instance $Hrs_01_01 name: "Min_02_04" position:[39,0,0.5]
instance $Hrs_01_02 name: "Min_02_05" position:[31,-8,0.5]
instance $Hrs_01_02 name: "Min_02_06" position:[46.9,-8,0.5]
instance $Hrs_01_01 name: "Min_02_07" position:[39,-16,0.5]
-------------------------------------------------------------------------------------------------------	
--Material assigning
-------------------------------------------------------------------------------------------------------
max select all
$.wirecolor = color 28 28 177
$.material = meditMaterials[1]
clearSelection()
completeRedraw()
-------------------------------------------------------------------------------------------------------	
	--Creating arrays with geometry
-------------------------------------------------------------------------------------------------------
	arr_Min01 = #()
	arr_Min02 = #()
	arr_Hrs01 = #()
	arr_Hrs02 = #()	
	for i=1 to 7 do(
		
		str_num = "0"+i as string
		
		str_min01 = "select $Min_01_"
		str_selection_min01 =str_min01+str_num
		execute str_selection_min01
		join arr_Min01 selection
		
		str_min02 = "select $Min_02_"
		str_selection_min02 =str_min02+str_num
		execute str_selection_min02
		join arr_Min02 selection
		
		str_hrs01 = "select $Hrs_01_"
		str_selection_hrs01 =str_hrs01+str_num
		execute str_selection_hrs01
		join arr_Hrs01 selection
		
		str_hrs02 = "select $Hrs_02_"
		str_selection_hrs02 =str_hrs02+str_num
		execute str_selection_hrs02
		join arr_Hrs02 selection
		)	
-------------------------------------------------------------------------------------------------------
--Creating function fn_Number
-------------------------------------------------------------------------------------------------------	
	function fn_Number arr_Num = (
	arr_Num=arr
		in coordsys local(
			str_check1=arr_Num[1].rotation as string  	
			str_check2=arr_Num[2].rotation as string
			str_check3=arr_Num[3].rotation as string  	
			str_check4=arr_Num[4].rotation as string	
			str_check5=arr_Num[5].rotation as string	
			str_check6=arr_Num[6].rotation as string	
			str_check7=arr_Num[7].rotation as string
			case Num of(
			1: (					
				if str_check1=="(quat 0 0 0 -1)" then rotate arr_Num[1] (angleaxis -180 [1,0,0]) else rotate arr_Num[1] (angleaxis 0 [1,0,0])
				if str_check2=="(quat 0 0 0 -1)" then rotate arr_Num[2] (angleaxis -180 [1,0,0]) else rotate arr_Num[2] (angleaxis 0 [1,0,0])
				if str_check3=="(quat 0 0 0 1)" then rotate arr_Num[3] (angleaxis -180 [1,0,0]) else rotate arr_Num[3] (angleaxis 0 [1,0,0]) 
				if str_check4=="(quat 0 0 0 -1)" then rotate arr_Num[4] (angleaxis -180 [1,0,0]) else rotate arr_Num[4] (angleaxis 0 [1,0,0])
				if str_check5=="(quat 0 0 0 -1)" then rotate arr_Num[5] (angleaxis -180 [1,0,0]) else rotate arr_Num[5] (angleaxis 0 [1,0,0])
				if str_check6=="(quat 0 0 0 1)" then rotate arr_Num[6] (angleaxis -180 [1,0,0]) else rotate arr_Num[6] (angleaxis 0 [1,0,0])
				if str_check7=="(quat 0 0 0 -1)" then rotate arr_Num[7] (angleaxis -180 [1,0,0]) else rotate arr_Num[7] (angleaxis 0 [1,0,0])
			)
			2: (					
				if str_check1=="(quat 0 0 0 1)" then rotate arr_Num[1] (angleaxis -180 [1,0,0]) else rotate arr_Num[1] (angleaxis 0 [1,0,0])
				if str_check2=="(quat 0 0 0 -1)" then rotate arr_Num[2] (angleaxis -180 [1,0,0]) else rotate arr_Num[2] (angleaxis 0 [1,0,0])
				if str_check3=="(quat 0 0 0 1)" then rotate arr_Num[3] (angleaxis -180 [1,0,0]) else rotate arr_Num[3] (angleaxis 0 [1,0,0])
				if str_check4=="(quat 0 0 0 1)" then rotate arr_Num[4] (angleaxis -180 [1,0,0]) else rotate arr_Num[4] (angleaxis 0 [1,0,0])
				if str_check5=="(quat 0 0 0 1)" then rotate arr_Num[5] (angleaxis -180 [1,0,0]) else rotate arr_Num[5] (angleaxis 0 [1,0,0])
				if str_check6=="(quat 0 0 0 -1)" then rotate arr_Num[6] (angleaxis -180 [1,0,0]) else rotate arr_Num[6] (angleaxis 0 [1,0,0])
				if str_check7=="(quat 0 0 0 1)" then rotate arr_Num[7] (angleaxis -180 [1,0,0]) else rotate arr_Num[7] (angleaxis 0 [1,0,0])
			)
			3: (					
				if str_check1=="(quat 0 0 0 1)" then rotate arr_Num[1] (angleaxis -180 [1,0,0]) else rotate arr_Num[1] (angleaxis 0 [1,0,0])
				if str_check2=="(quat 0 0 0 -1)" then rotate arr_Num[2] (angleaxis -180 [1,0,0]) else rotate arr_Num[2] (angleaxis 0 [1,0,0])
				if str_check3=="(quat 0 0 0 1)" then rotate arr_Num[3] (angleaxis -180 [1,0,0]) else rotate arr_Num[3] (angleaxis 0 [1,0,0])
				if str_check4=="(quat 0 0 0 1)" then rotate arr_Num[4] (angleaxis -180 [1,0,0]) else rotate arr_Num[4] (angleaxis 0 [1,0,0])
				if str_check5=="(quat 0 0 0 -1)" then rotate arr_Num[5] (angleaxis -180 [1,0,0]) else rotate arr_Num[5] (angleaxis 0 [1,0,0])
				if str_check6=="(quat 0 0 0 1)" then rotate arr_Num[6] (angleaxis -180 [1,0,0]) else rotate arr_Num[6] (angleaxis 0 [1,0,0])
				if str_check7=="(quat 0 0 0 1)" then rotate arr_Num[7] (angleaxis -180 [1,0,0]) else rotate arr_Num[7] (angleaxis 0 [1,0,0])
			)
			4: (					
				if str_check1=="(quat 0 0 0 -1)" then rotate arr_Num[1] (angleaxis -180 [1,0,0]) else rotate arr_Num[1] (angleaxis 0 [1,0,0])
				if str_check2=="(quat 0 0 0 1)" then rotate arr_Num[2] (angleaxis -180 [1,0,0]) else rotate arr_Num[2] (angleaxis 0 [1,0,0])
				if str_check3=="(quat 0 0 0 1)" then rotate arr_Num[3] (angleaxis -180 [1,0,0]) else rotate arr_Num[3] (angleaxis 0 [1,0,0])
				if str_check4=="(quat 0 0 0 1)" then rotate arr_Num[4] (angleaxis -180 [1,0,0]) else rotate arr_Num[4] (angleaxis 0 [1,0,0])
				if str_check5=="(quat 0 0 0 -1)" then rotate arr_Num[5] (angleaxis -180 [1,0,0]) else rotate arr_Num[5] (angleaxis 0 [1,0,0])
				if str_check6=="(quat 0 0 0 1)" then rotate arr_Num[6] (angleaxis -180 [1,0,0]) else rotate arr_Num[6] (angleaxis 0 [1,0,0])
				if str_check7=="(quat 0 0 0 -1)" then rotate arr_Num[7] (angleaxis -180 [1,0,0]) else rotate arr_Num[7] (angleaxis 0 [1,0,0])
			)
			5: (					
				if str_check1=="(quat 0 0 0 1)" then rotate arr_Num[1] (angleaxis -180 [1,0,0]) else rotate arr_Num[1] (angleaxis 0 [1,0,0])
				if str_check2=="(quat 0 0 0 1)" then rotate arr_Num[2] (angleaxis -180 [1,0,0]) else rotate arr_Num[2] (angleaxis 0 [1,0,0])
				if str_check3=="(quat 0 0 0 -1)" then rotate arr_Num[3] (angleaxis -180 [1,0,0]) else rotate arr_Num[3] (angleaxis 0 [1,0,0])
				if str_check4=="(quat 0 0 0 1)" then rotate arr_Num[4] (angleaxis -180 [1,0,0]) else rotate arr_Num[4] (angleaxis 0 [1,0,0])
				if str_check5=="(quat 0 0 0 -1)" then rotate arr_Num[5] (angleaxis -180 [1,0,0]) else rotate arr_Num[5] (angleaxis 0 [1,0,0])
				if str_check6=="(quat 0 0 0 1)" then rotate arr_Num[6] (angleaxis -180 [1,0,0]) else rotate arr_Num[6] (angleaxis 0 [1,0,0])
				if str_check7=="(quat 0 0 0 1)" then rotate arr_Num[7] (angleaxis -180 [1,0,0]) else rotate arr_Num[7] (angleaxis 0 [1,0,0])
			)
			6:(					
				if str_check1=="(quat 0 0 0 1)" then rotate arr_Num[1] (angleaxis -180 [1,0,0]) else rotate arr_Num[1] (angleaxis 0 [1,0,0])
				if str_check2=="(quat 0 0 0 1)" then rotate arr_Num[2] (angleaxis -180 [1,0,0]) else rotate arr_Num[2] (angleaxis 0 [1,0,0])
				if str_check3=="(quat 0 0 0 -1)" then rotate arr_Num[3] (angleaxis -180 [1,0,0]) else rotate arr_Num[3] (angleaxis 0 [1,0,0])
				if str_check4=="(quat 0 0 0 1)" then rotate arr_Num[4] (angleaxis -180 [1,0,0]) else rotate arr_Num[4] (angleaxis 0 [1,0,0])
				if str_check5=="(quat 0 0 0 1)" then rotate arr_Num[5] (angleaxis -180 [1,0,0]) else rotate arr_Num[5] (angleaxis 0 [1,0,0])
				if str_check6=="(quat 0 0 0 1)" then rotate arr_Num[6] (angleaxis -180 [1,0,0]) else rotate arr_Num[6] (angleaxis 0 [1,0,0])
				if str_check7=="(quat 0 0 0 1)" then rotate arr_Num[7] (angleaxis -180 [1,0,0]) else rotate arr_Num[7] (angleaxis 0 [1,0,0])
			)
			7:(					
				if str_check1=="(quat 0 0 0 1)" then rotate arr_Num[1] (angleaxis -180 [1,0,0]) else rotate arr_Num[1] (angleaxis 0 [1,0,0])
				if str_check2=="(quat 0 0 0 -1)" then rotate arr_Num[2] (angleaxis -180 [1,0,0]) else rotate arr_Num[2] (angleaxis 0 [1,0,0])
				if str_check3=="(quat 0 0 0 1)" then rotate arr_Num[3] (angleaxis -180 [1,0,0]) else rotate arr_Num[3] (angleaxis 0 [1,0,0])
				if str_check4=="(quat 0 0 0 -1)" then rotate arr_Num[4] (angleaxis -180 [1,0,0]) else rotate arr_Num[4] (angleaxis 0 [1,0,0])
				if str_check5=="(quat 0 0 0 -1)" then rotate arr_Num[5] (angleaxis -180 [1,0,0]) else rotate arr_Num[5] (angleaxis 0 [1,0,0])
				if str_check6=="(quat 0 0 0 1)" then rotate arr_Num[6] (angleaxis -180 [1,0,0]) else rotate arr_Num[6] (angleaxis 0 [1,0,0])
				if str_check7=="(quat 0 0 0 -1)" then rotate arr_Num[7] (angleaxis -180 [1,0,0]) else rotate arr_Num[7] (angleaxis 0 [1,0,0])
			)
			8:(					
				if str_check1=="(quat 0 0 0 1)" then rotate arr_Num[1] (angleaxis -180 [1,0,0]) else rotate arr_Num[1] (angleaxis 0 [1,0,0])
				if str_check2=="(quat 0 0 0 1)" then rotate arr_Num[2] (angleaxis -180 [1,0,0]) else rotate arr_Num[2] (angleaxis 0 [1,0,0])
				if str_check3=="(quat 0 0 0 1)" then rotate arr_Num[3] (angleaxis -180 [1,0,0]) else rotate arr_Num[3] (angleaxis 0 [1,0,0])
				if str_check4=="(quat 0 0 0 1)" then rotate arr_Num[4] (angleaxis -180 [1,0,0]) else rotate arr_Num[4] (angleaxis 0 [1,0,0])
				if str_check5=="(quat 0 0 0 1)" then rotate arr_Num[5] (angleaxis -180 [1,0,0]) else rotate arr_Num[5] (angleaxis 0 [1,0,0])
				if str_check6=="(quat 0 0 0 1)" then rotate arr_Num[6] (angleaxis -180 [1,0,0]) else rotate arr_Num[6] (angleaxis 0 [1,0,0])
				if str_check7=="(quat 0 0 0 1)" then rotate arr_Num[7] (angleaxis -180 [1,0,0]) else rotate arr_Num[7] (angleaxis 0 [1,0,0])
			)
			9:(					
				if str_check1=="(quat 0 0 0 1)" then rotate arr_Num[1] (angleaxis -180 [1,0,0]) else rotate arr_Num[1] (angleaxis 0 [1,0,0])
				if str_check2=="(quat 0 0 0 1)" then rotate arr_Num[2] (angleaxis -180 [1,0,0]) else rotate arr_Num[2] (angleaxis 0 [1,0,0])
				if str_check3=="(quat 0 0 0 1)" then rotate arr_Num[3] (angleaxis -180 [1,0,0]) else rotate arr_Num[3] (angleaxis 0 [1,0,0])
				if str_check4=="(quat 0 0 0 1)" then rotate arr_Num[4] (angleaxis -180 [1,0,0]) else rotate arr_Num[4] (angleaxis 0 [1,0,0])
				if str_check5=="(quat 0 0 0 -1)" then rotate arr_Num[5] (angleaxis -180 [1,0,0]) else rotate arr_Num[5] (angleaxis 0 [1,0,0])
				if str_check6=="(quat 0 0 0 1)" then rotate arr_Num[6] (angleaxis -180 [1,0,0]) else rotate arr_Num[6] (angleaxis 0 [1,0,0])
				if str_check7=="(quat 0 0 0 1)" then rotate arr_Num[7] (angleaxis -180 [1,0,0]) else rotate arr_Num[7] (angleaxis 0 [1,0,0])
			)
			0:(					
				if str_check1=="(quat 0 0 0 1)" then rotate arr_Num[1] (angleaxis -180 [1,0,0]) else rotate arr_Num[1] (angleaxis 0 [1,0,0])
				if str_check2=="(quat 0 0 0 1)" then rotate arr_Num[2] (angleaxis -180 [1,0,0]) else rotate arr_Num[2] (angleaxis 0 [1,0,0])
				if str_check3=="(quat 0 0 0 1)" then rotate arr_Num[3] (angleaxis -180 [1,0,0]) else rotate arr_Num[3] (angleaxis 0 [1,0,0])
				if str_check4=="(quat 0 0 0 -1)" then rotate arr_Num[4] (angleaxis -180 [1,0,0]) else rotate arr_Num[4] (angleaxis 0 [1,0,0])
				if str_check5=="(quat 0 0 0 1)" then rotate arr_Num[5] (angleaxis -180 [1,0,0]) else rotate arr_Num[5] (angleaxis 0 [1,0,0])
				if str_check6=="(quat 0 0 0 1)" then rotate arr_Num[6] (angleaxis -180 [1,0,0]) else rotate arr_Num[6] (angleaxis 0 [1,0,0])
				if str_check7=="(quat 0 0 0 1)" then rotate arr_Num[7] (angleaxis -180 [1,0,0]) else rotate arr_Num[7] (angleaxis 0 [1,0,0])
			)
			"black":(					
				if str_check1=="(quat 0 0 0 -1)" then rotate arr_Num[1] (angleaxis -180 [1,0,0]) else rotate arr_Num[1] (angleaxis 0 [1,0,0])
				if str_check2=="(quat 0 0 0 -1)" then rotate arr_Num[2] (angleaxis -180 [1,0,0]) else rotate arr_Num[2] (angleaxis 0 [1,0,0])
				if str_check3=="(quat 0 0 0 -1)" then rotate arr_Num[3] (angleaxis -180 [1,0,0]) else rotate arr_Num[3] (angleaxis 0 [1,0,0])
				if str_check4=="(quat 0 0 0 -1)" then rotate arr_Num[4] (angleaxis -180 [1,0,0]) else rotate arr_Num[4] (angleaxis 0 [1,0,0])
				if str_check5=="(quat 0 0 0 -1)" then rotate arr_Num[5] (angleaxis -180 [1,0,0]) else rotate arr_Num[5] (angleaxis 0 [1,0,0])
				if str_check6=="(quat 0 0 0 -1)" then rotate arr_Num[6] (angleaxis -180 [1,0,0]) else rotate arr_Num[6] (angleaxis 0 [1,0,0])
				if str_check7=="(quat 0 0 0 -1)" then rotate arr_Num[7] (angleaxis -180 [1,0,0]) else rotate arr_Num[7] (angleaxis 0 [1,0,0])
			)
			default:(					
				if str_check1=="(quat 0 0 0 1)" then rotate arr_Num[1] (angleaxis -180 [1,0,0]) else rotate arr_Num[1] (angleaxis 0 [1,0,0])
				if str_check2=="(quat 0 0 0 1)" then rotate arr_Num[2] (angleaxis -180 [1,0,0]) else rotate arr_Num[2] (angleaxis 0 [1,0,0])
				if str_check3=="(quat 0 0 0 1)" then rotate arr_Num[3] (angleaxis -180 [1,0,0]) else rotate arr_Num[3] (angleaxis 0 [1,0,0])
				if str_check4=="(quat 0 0 0 1)" then rotate arr_Num[4] (angleaxis -180 [1,0,0]) else rotate arr_Num[4] (angleaxis 0 [1,0,0])
				if str_check5=="(quat 0 0 0 1)" then rotate arr_Num[5] (angleaxis -180 [1,0,0]) else rotate arr_Num[5] (angleaxis 0 [1,0,0])
				if str_check6=="(quat 0 0 0 1)" then rotate arr_Num[6] (angleaxis -180 [1,0,0]) else rotate arr_Num[6] (angleaxis 0 [1,0,0])
				if str_check7=="(quat 0 0 0 1)" then rotate arr_Num[7] (angleaxis -180 [1,0,0]) else rotate arr_Num[7] (angleaxis 0 [1,0,0])
				)
			)
		)
	return arr		
	)
	fn_Number arr_Hrs01 (spn_st_hrs.value/10)
	fn_Number arr_Hrs02 (spn_st_hrs.value-(spn_st_hrs.value/10)*10)
	fn_Number arr_Min01 (spn_st_min.value/10)
	fn_Number arr_Min02 (spn_st_min.value-(spn_st_min.value/10)*10)
	in coordsys local
		(
		str_check_sec=$Sec01.rotation as string
		if str_check_sec=="(quat 0 0 0 1)" then rotate $Sec01 (angleaxis -180 [1,0,0])
		str_check_sec=$Sec02.rotation as string
		if str_check_sec=="(quat 0 0 0 1)" then rotate $Sec02 (angleaxis -180 [1,0,0])		
		)
)
-------------------------------------------------------------------------------------------------------	
--Start time hours spinner
-------------------------------------------------------------------------------------------------------
	on spn_st_hrs changed st_hrs do (
	fn_Number arr_Hrs01 (st_hrs/10)
	fn_Number arr_Hrs02 (st_hrs-(st_hrs/10)*10)
	)
-------------------------------------------------------------------------------------------------------	
--Start time minutes spinner
-------------------------------------------------------------------------------------------------------
	on spn_st_min changed st_min do (
	fn_Number arr_Min01 (st_min/10)
	fn_Number arr_Min02 (st_min-(st_min/10)*10)
	)
-------------------------------------------------------------------------------------------------------	
--CheckBox parametres
-------------------------------------------------------------------------------------------------------	
	on chk_et changed state do (	
	if chk_et.checked==true then 
		(
		spn_et_hrs.enabled=true
		spn_et_min.enabled=true
		spn_dur_hrs.enabled=false
		spn_dur_min.enabled=false	
		)
		else 
		(
		spn_et_hrs.enabled=false
		spn_et_min.enabled=false
		spn_dur_hrs.enabled=true
		spn_dur_min.enabled=true
		)
	)	
-------------------------------------------------------------------------------------------------------	
--Duration time hours spinner
-------------------------------------------------------------------------------------------------------	
	on spn_dur_hrs changed dur_hrs do (
	sum_hrs=dur_hrs+spn_st_hrs.value
	dur_days=sum_hrs/24
	et_hrs=sum_hrs-dur_days*24
	spn_et_hrs.value=et_hrs
	)	
-------------------------------------------------------------------------------------------------------	
--Duration time minutes spinner
-------------------------------------------------------------------------------------------------------	
	on spn_dur_min changed dur_min do (
		st_min=spn_st_min.value
		et_hrs=spn_et_hrs.value
		et_min=st_min+dur_min
		if et_min>59 do
		(
		et_hrs+=1
		et_min-=60
		)
		spn_et_hrs.value=et_hrs
		spn_et_min.value=et_min
	)
-------------------------------------------------------------------------------------------------------	
--End time hours spinner
-------------------------------------------------------------------------------------------------------
	on spn_et_hrs changed et_hrs do (
		if spn_st_hrs.value>et_hrs then
		(
		spn_dur_hrs.range=[0,23,24-(spn_st_hrs.value-et_hrs)]	
		)
		else
		(
		spn_dur_hrs.range=[0,23,et_hrs-spn_st_hrs.value]	
		)
	)
-------------------------------------------------------------------------------------------------------	
--End time minutes spinner
-------------------------------------------------------------------------------------------------------
	on spn_et_min changed et_min do (
		if spn_st_min.value>et_min then
		(
		spn_dur_min.range=[0,59,60-(spn_st_min.value-et_min)]
		spn_dur_hrs.range=[0,23,23]	
		)
		else
		(
		spn_dur_min.range=[0,59,et_min-spn_st_min.value]
		)	
	)
-------------------------------------------------------------------------------------------------------	
--Frames per minute spinner
-------------------------------------------------------------------------------------------------------	
	on spn_fpm changed fpm do (
	animationRange = interval 0 (spn_fpm.value*(spn_dur_min.value+60*spn_dur_hrs.value)+spn_fpm.value)	
	)	
-------------------------------------------------------------------------------------------------------	
--Reset button
-------------------------------------------------------------------------------------------------------	
	on btn_reset pressed do (	
			sliderTime=0f	
			max select all
			fn_Number arr_Hrs01 (spn_st_hrs.value/10)
			fn_Number arr_Hrs02 (spn_st_hrs.value-(spn_st_hrs.value/10)*10)
			fn_Number arr_Min01 (spn_st_min.value/10)
			fn_Number arr_Min02 (spn_st_min.value-(spn_st_min.value/10)*10)		
			deleteKeys $selection	
			in coordsys local
			(
				str_check_sec=$Sec01.rotation as string
				if str_check_sec=="(quat 0 0 0 -1)" then rotate $Sec01 (angleaxis -180 [1,0,0])	
				str_check_sec=$Sec02.rotation as string
				if str_check_sec=="(quat 0 0 0 -1)" then rotate $Sec02 (angleaxis -180 [1,0,0])	
			)
			clearSelection()
			animationRange = interval 0 100
	)
-------------------------------------------------------------------------------------------------------	
--Create button
-------------------------------------------------------------------------------------------------------	
	on btn_create pressed do (	
		sliderTime=0f
		max select all
		deleteKeys $selection
		clearSelection()
		animationRange = interval 0 (spn_fpm.value*(spn_dur_min.value+60*spn_dur_hrs.value)+spn_fpm.value-1)
		animate on(
			--Cicle minutes
			for b=spn_st_min.value to b=59 do(
				local md1=spn_fpm.value*b
				local md2=(spn_fpm.value*(b+1)-1)
				at time md2 (
					fn_Number arr_Min01 (b/10)
					fn_Number arr_Min02 (b-(b/10)*10)
				)
				at time md1 (
					fn_Number arr_Min01 (b/10)
					fn_Number arr_Min02 (b-(b/10)*10)
				)				
			)
			--Cicle hours
			for i=0 to i=spn_dur_hrs.value do(
				local b=i+spn_st_hrs.value
				local h1=spn_fpm.value*i*60
				local h2=spn_fpm.value*i*60-1
				local h3=spn_fpm.value*(i+1)*60-1
				local h4=spn_fpm.value*(i+1)*60
				at time h2 (
					fn_Number arr_Hrs01 ((b-1)/10)
					fn_Number arr_Hrs02 ((b-1)-((b-1)/10)*10)
				)
				at time h1 (
					fn_Number arr_Hrs01 (b/10)
					fn_Number arr_Hrs02 (b-(b/10)*10)
				)				
				--Cicle minutes for hours
				for a=0 to a=59 do(
					local m1=spn_fpm.value*a+h4
					local m2=spn_fpm.value*(a+1)+h3
					at time m2 (
						fn_Number arr_Min01 (a/10)
						fn_Number arr_Min02 (a-(a/10)*10)
					)
					at time m1 (
						fn_Number arr_Min01 (a/10)
						fn_Number arr_Min02 (a-(a/10)*10)
					)
				)
				at time h3 (
					fn_Number arr_Min01 5
					fn_Number arr_Min02 9
				)
			)
		)
		mov_key=-(spn_st_min.value*spn_fpm.value)
		select arr_Min01
		selectMore arr_Min02
		selectMore arr_Hrs01
		selectMore arr_Hrs02
		moveKeys $selection mov_key 
		clearSelection()
	)	
-------------------------------------------------------------------------------------------------------	
--Closing Clock_Rollout
-------------------------------------------------------------------------------------------------------	
	on Clock_Rollout close do (

		)	
	on Clock_Rollout moved pos do (			
		)
)
CreateDialog Clock_Rollout