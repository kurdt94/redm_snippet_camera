local transition_time = 1000
local cam_location = {x= -245.40518188477, y= 672.02960205078, z= 115.03829193115, h= 229.01280212402}
local point_cam_location = {x= -237.36674499512, y= 666.12780761719, z= 112.31346893311, h= 231.31733703613}

local cam = false
function DoStartCam()
        print("start camera")
        Citizen.Wait(100)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", cam_location.x, cam_location.y, cam_location.z+2, 300.00, 0.00, 0.00, 70.00, false, 0)
        SetCamActive(cam, true)
        PointCamAtCoord(cam, point_cam_location.x,point_cam_location.y,point_cam_location.z)
        RenderScriptCams(true,true,transition_time,true)
end

function DoEndCam()
    print("end camera")
    DestroyCam(cam, true)
    -- Citizen.InvokeNative(0x163600D6E136C9F8,true) -- DESTROY_ALL_CAMS
end

RegisterCommand("startcam", function(source, args, rawCommand)
    DisplayHud(false)
    DisplayRadar(false)
    DoStartCam()
end,false)

RegisterCommand("endcam", function(source, args, rawCommand)
    Citizen.Wait(transition_time)
    Citizen.InvokeNative(0x5D1EB123EAC5D071, 0.0, 1065353216) -- SET_GAMEPLAY_CAM_RELATIVE_HEADING
    DisplayHud(true)
    DisplayRadar(true)
    RenderScriptCams(false,true,transition_time,true,true)
    DoEndCam()
end,false)
