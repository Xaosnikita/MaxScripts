rollout Rollout_Batch_Model_Render "Batch models render" width:160 height:200
(
	local thePath_models = undefined
	local thePath_render = undefined
	editText 'edt_M_Folder' "" pos:[8,32] width:144 height:15 align:#left
	button 'btn_Models' "Pick folder" pos:[32,56] width:99 height:19 align:#left
	label 'lbl2' "Folder with models:" pos:[24,8] width:120 height:16 align:#left
	editText 'edt_R_Folder' "" pos:[8,112] width:144 height:15 align:#left
	button 'btn_Renders' "Pick folder" pos:[32,136] width:99 height:19 align:#left
	label 'lbl3' "Folder for renders:" pos:[24,88] width:120 height:16 enabled:true align:#left
	button 'btn_Start' "Start" pos:[32,168] width:99 height:19 align:#left
	on btn_Models pressed  do
	(
		thePath_models = getSavePath caption:"Select folder with models" initialDir:(maxFilePath)--get a path dialog to specify the path
		if thePath_models != undefined do--if the user did not cancel
		(
			edt_M_Folder.text =thePath_models			
		)
	)
	on btn_Renders pressed  do
(
		thePath_render = getSavePath caption:"Select folder for renders" initialDir:(maxFilePath) --get a path dialog to specify the path
		if thePath_render != undefined do--if the user did not cancel
		(
			edt_R_Folder.text =thePath_render			
		)
	
	)
	on btn_Start pressed  do
(
	if thePath_models == undefined do(messageBox("Select models folder")) --if folder not choosen
	if thePath_render == undefined do(messageBox("Select renders folder"))	--if folder not choosen
	if thePath_models != undefined do(
		if thePath_render != undefined do(
	(		

	theFiles = getFiles (thePath_models+"\\*.max") --collect all max files in the dir.		
		for f in theFiles do-- go through all of them
			(
			mergemaxfile f  #select #AutoRenameDups #renameMtlDups -- merge in the objects and select them, rename dups
			--print(f)  -- just checking
			int_Path_models = thePath_models.count+2
			int_f = f.count 
			int_count = int_f - int_Path_models-3
			new_str = substring f int_Path_models int_count
			--print(new_str)	 -- just checking
			rendername=  thePath_render+"\\"+new_str+ ".jpg"
			--print(rendername)  -- just checking
			render vfb:off outputFile:(rendername)	--starts render and save results in "rendername" path
			delete $	--deletes merged model
				)
			)
	)))
	on Rollout_Batch_Model_Render close do
	(
		thePath_models = undefined
		thePath_render = undefined
		)
)

createDialog Rollout_Batch_Model_Render()

