local start_time = os.clock()
local do_once = false
local ffi = require("ffi")
local XPLM = nil
local XPLMlib = "XPLM"
if SYSTEM_ARCHITECTURE == 64 then
	XPLMlib = "XPLM_64"
end
XPLM = ffi.load(XPLMlib)
local ffi = require("ffi")
local XPLM = ffi.load("XPLM_64")
ffi.cdef( "typedef void * XPLMDataRef;")
ffi.cdef( "XPLMDataRef XPLMFindDataRef(const char *inDataRefName);" )
ffi.cdef( "int XPLMGetDatai(XPLMDataRef inDataRef);" )
ffi.cdef( "void XPLMSetDatai(XPLMDataRef inDataRef, int inValue);" )
ffi.cdef( "float XPLMGetDataf(XPLMDataRef inDataRef);" )
ffi.cdef( "void XPLMSetDataf(XPLMDataRef inDataRef, float inValue);" )
ffi.cdef( "double XPLMGetDatad(XPLMDataRef inDataRef);" )
ffi.cdef( "void XPLMSetDatad(XPLMDataRef inDataRef, double inValue);" )
function findDataref(drName)
    return XPLM.XPLMFindDataRef(drName)
end
function setData(handle, value, isFloat)
	if isFloat then
		XPLM.XPLMSetDataf(handle, value)
	else
		XPLM.XPLMSetDatai(handle, value)
	end
end
function getDatai(handle)
    return XPLM.XPLMGetDatai(handle)
end
function setDataf(handle, value)
    XPLM.XPLMSetDataf(handle, value)
end
function getDataf(handle)
    return XPLM.XPLMGetDataf(handle)
end
function setDatad(handle, value)
    XPLM.XPLMSetDatad(handle, value)
end
function getDatad(handle)
    return XPLM.XPLMGetDatad(handle)
end

function save_default_settings()

	AURORA_BOREALIS=getDataf(findDataref("sim/private/controls/reno/draw_aurora"))
	CARRIERS_FRIGATES=getDataf(findDataref("sim/private/controls/reno/draw_boats"))
	BIRDS_DEER=getDataf(findDataref("sim/private/controls/reno/draw_deer_birds"))
	FIRES_BALOONS=getDataf(findDataref("sim/private/controls/reno/draw_fire_ball"))
	DISTANCE_TRAFFIC=getDataf(findDataref("sim/private/controls/cars/lod_min"))
	DISTANCE_PLANS=getDataf(findDataref("sim/private/controls/park/static_plane_build_dis"))
	RUNWAYS_CONTOURS=getDataf(findDataref("sim/private/controls/reno/sloped_runways"))
	ATMOSPHERIC_SCATTERING=getDataf(findDataref("sim/private/controls/reno/draw_scattering"))
	VOLUMETRIC_FOG=getDataf(findDataref("sim/private/controls/reno/draw_volume_fog01"))
	PIXEL_LIGHTING=getDataf(findDataref("sim/private/controls/reno/draw_per_pix_liting"))
	OBJECT_DENSITY=getDataf(findDataref("sim/private/controls/reno/draw_objs_06"))
	TRAFFIC_DENSITY=getDataf(findDataref("sim/private/controls/reno/draw_cars_05"))
	ROAD_DENSITY=getDataf(findDataref("sim/private/controls/reno/draw_vecs_03"))
	TAXIWAY_SMOOTHNESS=getDataf(findDataref("sim/private/controls/reno/draw_detail_apt_03"))
	FOREST_DENSITY=getDataf(findDataref("sim/private/controls/reno/draw_for_05"))
	FOREST_INNER=getDataf(findDataref("sim/private/controls/forest/inn_ring_density"))
	FOREST_MID=getDataf(findDataref("sim/private/controls/forest/mid_ring_density"))
	FOREST_OUTER=getDataf(findDataref("sim/private/controls/forest/out_ring_density"))
	FADE_RATE=getDataf(findDataref("sim/private/controls/terrain/fade_start_rat"))
	LOD_BIAS=getDataf(findDataref("sim/private/controls/ag/tile_lod_bias"))
	DISTANCE_BIAS=getDataf(findDataref("sim/private/controls/terrain/composite_far_dist_bias"))
	WATER_REFLECTION=getDataf(findDataref("sim/private/controls/reno/draw_reflect_water05"))
	COMPRESS_TEXTURES=getDataf(findDataref("sim/private/controls/reno/comp_texes"))
	BUMPMAP_TEXTURES=getDataf(findDataref("sim/private/controls/reno/use_bump_maps"))
	DETAIL_TEXTURES=getDataf(findDataref("sim/private/controls/reno/use_detail_textures"))
	AMBIENT_OCCLUSION=getDataf(findDataref("sim/private/controls/ssao/enable"))
	STATIC_PLANE_DENSITY=getDataf(findDataref("sim/private/controls/park/static_plane_density"))
	SHADOW_EXTERIOR=getDataf(findDataref("sim/private/controls/shadow/csm_split_exterior"))
	SHADOW_FADE=getDataf(findDataref("sim/private/controls/shadow/csm/far_limit"))
	SHADOW_SIZE=getDataf(findDataref("sim/private/controls/fbo/shadow_cam_size"))
	GROUND_VISIBLE=getDataf(findDataref("sim/private/controls/skyc/max_dsf_vis_ever"))
	GROUND_FADING=getDataf(findDataref("sim/private/controls/skyc/dsf_fade_ratio"))
	REFLECTIVE_WATER=getDataf(findDataref("sim/private/controls/caps/use_reflective_water"))
	FFT_WATER=getDataf(findDataref("sim/private/controls/reno/draw_fft_water"))
	COCKPIT_PROXY=getDataf(findDataref("sim/private/controls/shadow/cockpit_near_proxy"))
	COCKPIT_NEAR=getDataf(findDataref("sim/private/controls/shadow/cockpit_near_adjust"))
	CLOUD_PUFFS=getDataf(findDataref("sim/private/controls/clouds/overdraw_control"))
	CLOUDS_RADIUS=getDataf(findDataref("sim/private/controls/clouds/plot_radius"))
	OBJ_LODBIAS=getDataf(findDataref("sim/private/controls/reno/LOD_bias_rat"))
	HDR=getDataf(findDataref("sim/private/controls/reno/draw_HDR"))

	defaultfile = io.open(SCRIPT_DIRECTORY .. "default_settings.txt", "w")
	defaultfile:write("sim/private/controls/reno/draw_aurora=" .. AURORA_BOREALIS, "\n")
	defaultfile:write("sim/private/controls/reno/draw_boats=" .. CARRIERS_FRIGATES, "\n")
	defaultfile:write("sim/private/controls/reno/draw_deer_birds=" .. BIRDS_DEER, "\n")
	defaultfile:write("sim/private/controls/reno/draw_fire_ball=" .. FIRES_BALOONS, "\n")
	defaultfile:write("sim/private/controls/cars/lod_min=" .. DISTANCE_TRAFFIC, "\n")
	defaultfile:write("sim/private/controls/park/static_plane_build_dis=" .. DISTANCE_PLANS, "\n")
	defaultfile:write("sim/private/controls/reno/sloped_runways=" .. RUNWAYS_CONTOURS, "\n")
	defaultfile:write("sim/private/controls/reno/draw_scattering=" .. ATMOSPHERIC_SCATTERING, "\n")
	defaultfile:write("sim/private/controls/reno/draw_volume_fog01=" .. VOLUMETRIC_FOG, "\n")
	defaultfile:write("sim/private/controls/reno/draw_per_pix_liting=" .. PIXEL_LIGHTING, "\n")
	defaultfile:write("sim/private/controls/reno/draw_objs_06=" .. OBJECT_DENSITY, "\n")
	defaultfile:write("sim/private/controls/reno/draw_cars_05=" .. TRAFFIC_DENSITY, "\n")
	defaultfile:write("sim/private/controls/reno/draw_vecs_03=" .. ROAD_DENSITY, "\n")
	defaultfile:write("sim/private/controls/reno/draw_detail_apt_03=" .. TAXIWAY_SMOOTHNESS, "\n")
	defaultfile:write("sim/private/controls/reno/draw_for_05=" .. FOREST_DENSITY, "\n")
	defaultfile:write("sim/private/controls/forest/inn_ring_density=" .. FOREST_INNER, "\n")
	defaultfile:write("sim/private/controls/forest/mid_ring_density=" .. FOREST_MID, "\n")
	defaultfile:write("sim/private/controls/forest/out_ring_density=" .. FOREST_OUTER, "\n")
	defaultfile:write("sim/private/controls/terrain/fade_start_rat=" .. FADE_RATE, "\n")
	defaultfile:write("sim/private/controls/ag/tile_lod_bias=" .. LOD_BIAS, "\n")
	defaultfile:write("sim/private/controls/terrain/composite_far_dist_bias=" .. DISTANCE_BIAS, "\n")
	defaultfile:write("sim/private/controls/reno/draw_reflect_water05=" .. WATER_REFLECTION, "\n")
	defaultfile:write("sim/private/controls/reno/comp_texes=" .. COMPRESS_TEXTURES, "\n")
	defaultfile:write("sim/private/controls/reno/use_bump_maps=" .. BUMPMAP_TEXTURES, "\n")
	defaultfile:write("sim/private/controls/reno/use_detail_textures=" .. DETAIL_TEXTURES, "\n")
	defaultfile:write("sim/private/controls/ssao/enable=" .. AMBIENT_OCCLUSION, "\n")
	defaultfile:write("sim/private/controls/park/static_plane_density=" .. STATIC_PLANE_DENSITY, "\n")
	defaultfile:write("sim/private/controls/shadow/csm_split_exterior=" .. SHADOW_EXTERIOR, "\n")
	defaultfile:write("sim/private/controls/shadow/csm/far_limit=" .. SHADOW_FADE, "\n")
	defaultfile:write("sim/private/controls/fbo/shadow_cam_size=" .. SHADOW_SIZE, "\n")
	defaultfile:write("sim/private/controls/skyc/max_dsf_vis_ever=" .. GROUND_VISIBLE, "\n")
	defaultfile:write("sim/private/controls/skyc/dsf_fade_ratio=" .. GROUND_FADING, "\n")
	defaultfile:write("sim/private/controls/caps/use_reflective_water=" .. REFLECTIVE_WATER, "\n")
	defaultfile:write("sim/private/controls/reno/draw_fft_water=" .. FFT_WATER, "\n")
	defaultfile:write("sim/private/controls/shadow/cockpit_near_proxy=" .. COCKPIT_PROXY, "\n")
	defaultfile:write("sim/private/controls/shadow/cockpit_near_adjust=" .. COCKPIT_NEAR, "\n")
	defaultfile:write("sim/private/controls/clouds/overdraw_control=" .. CLOUD_PUFFS, "\n")
	defaultfile:write("sim/private/controls/clouds/plot_radius=" .. CLOUDS_RADIUS, "\n")
	defaultfile:write("sim/private/controls/reno/LOD_bias_rat=" .. OBJ_LODBIAS, "\n")
	defaultfile:write("sim/private/controls/reno/draw_HDR=" .. HDR, "\n")
	defaultfile:close()
end
function apply_settings()
    if os.clock() > start_time and do_once == false then

	save_default_settings()

	--Draw Aurora Borealis. 0 (off) or 1 (on)
	setData(findDataref("sim/private/controls/reno/draw_aurora"), 1, false)

	--Draw aircraft carriers and frigates. 0 (off) or 1 (on)
	setData(findDataref("sim/private/controls/reno/draw_boats"), 1.00, false)

	--Draw birds and deer in nice weather. 0 (off) or 1 (on)
	setData(findDataref("sim/private/controls/reno/draw_deer_birds"), 1.00, false)

	--Draw fires and baloons. 0 (off) or 1 (on)
	setData(findDataref("sim/private/controls/reno/draw_fire_ball"), 1.00, false)

	--Distance at which road traffic is visible. Default is 20000 meters. Recommend 7500.
	setData(findDataref("sim/private/controls/cars/lod_min"), 2400.00, true)

	--Distance at which static plans are visible. Default is 9260 meters. Recommend 3000.
	setData(findDataref("sim/private/controls/park/static_plane_build_dis"), 2370.00, true)

	--Runways follow terrain contours. 0 (off) or 1 (on)
	setData(findDataref("sim/private/controls/reno/sloped_runways"), 0.00, false)

	--Atmospheric scattering. 0 (off) or 1 (on)
	setData(findDataref("sim/private/controls/reno/draw_scattering"), 1.00, false)

	--Draw volumetric fog. 0 (off) or 1 (on)
	setData(findDataref("sim/private/controls/reno/draw_volume_fog01"), 1.00, false)

	--Draw per pixel lighting. 0 (off) or 1 (on). Change both of the settings below to be the same.
	setData(findDataref("sim/private/controls/reno/draw_per_pix_liting"), 1.00, false)

	--3D Object Density. 0 (None) to 6 (Extreme)
	setData(findDataref("sim/private/controls/reno/draw_objs_06"), 2, false)

	--Road traffic density. 0 (off) to 5 (very dense)
	setData(findDataref("sim/private/controls/reno/draw_cars_05"), 2, false)

	--Road Density. 0 (None) to 3 (Extreme)
	setData(findDataref("sim/private/controls/reno/draw_vecs_03"), 1, false)

	--Runway and taxiway line smoothness and 3D runway/taxiway lighting. 0 (Low) to 3 (Extreme)
	setData(findDataref("sim/private/controls/reno/draw_detail_apt_03"), 1, false)

	--Forest density. 0 (Low) to 5 (Extreme)
	setData(findDataref("sim/private/controls/reno/draw_for_05"), 1, false)

	--Forest inner ring density. 0 (0%) to 1 (100%)
	setData(findDataref("sim/private/controls/forest/inn_ring_density"), 1, true)

	--Forest mid ring density. 0 (0%) to 1 (100%)
	setData(findDataref("sim/private/controls/forest/mid_ring_density"), 2, true)

	--Forest outer ring density. 0 (0%) to 1 (100%)
	setData(findDataref("sim/private/controls/forest/out_ring_density"), 3, true)

	--Fade start rate. 0.75 (low setting) to 0.6 (high setting)
	setData(findDataref("sim/private/controls/terrain/fade_start_rat"), 0.41, true)

	--Tile LOD bias. 0.72 (low setting) to 1.0 (high setting)
	setData(findDataref("sim/private/controls/ag/tile_lod_bias"), 0.72, true)

	--Composite far distance bias. 0.72 (low setting) to 1.0 (high setting)
	setData(findDataref("sim/private/controls/terrain/composite_far_dist_bias"), 0.72, true)

	--Water reflection detail. 0 (None) to 5 (Complete)
	setData(findDataref("sim/private/controls/reno/draw_reflect_water05"), 3.00, false)

	--Compress textures to save VRAM. 0 (off) or 1 (on)
	setData(findDataref("sim/private/controls/reno/comp_texes"), 1.00, false)

	--Use bump map textures. 0 (off) or 1 (on)
	setData(findDataref("sim/private/controls/reno/use_bump_maps"), 0.00, false)

	--Use detail (aka gritty) textures or decals. 0 (off) or 1 (on)
	setData(findDataref("sim/private/controls/reno/use_detail_textures"), 1.00, false)

	--Ambient Occlusion. 0 (off) or 1 (on)
	setData(findDataref("sim/private/controls/ssao/enable"), 1.00, true)

	--Static plane density. 1 (low) to 6 (high). Note this does not affect static planes manually placed by scenery designer, just the ones that automatically appear and start areas.
	setData(findDataref("sim/private/controls/park/static_plane_density"), 1.00, true)

	--Cascading Shadow Maps Exterior Quality (Higher numbers reduce jagged edges of shadows). Known valid values are 1 or 2 for XP11.  XP10 used values of 0-5.
	setData(findDataref("sim/private/controls/shadow/csm_split_exterior"), 0.00, true)

	--Shadow fade distance. XP11 uses values ranging from 500 to 1500.  XP10 used values ranging from 500 to 6000.
	setData(findDataref("sim/private/controls/shadow/csm/far_limit"), 0.00, true)

	--Shadow texture size. Lower quality has jagged edges. 2048 (low quality), 4096 (medium quality), 8192 (high quality)
	setData(findDataref("sim/private/controls/fbo/shadow_cam_size"), 2048.00, true)

	--The following values adjust the maximum distance ground scenery is visible.  Default is 10000.  Larger values seem to have no affect, but you might try lower values if you have a low end system.
	setData(findDataref("sim/private/controls/skyc/max_dsf_vis_ever"), 10000, true)

	--The following values adjust fading of ground textures in the distance.  Default is 0.90 in XP10 (0.75 in XP 11).  Higher values have no effect.  But you might try lower values (0.10 for example) if you want the ground scenery to fade to brown more gradually in the distance.
	setData(findDataref("sim/private/controls/skyc/dsf_fade_ratio"), 0.75, true)

	--The following enables reflective water. Default is 1.00 (on)
	setData(findDataref("sim/private/controls/caps/use_reflective_water"), 0.00, true)

	-- Draw fft water
	setData(findDataref("sim/private/controls/reno/draw_fft_water"), 1.00, false)

	-- Cockpit near Proxy
	setData(findDataref("sim/private/controls/shadow/cockpit_near_proxy"), 1.00, true)

	-- Cockpit near adjust
	setData(findDataref("sim/private/controls/shadow/cockpit_near_adjust"), 1.00, true)

	-- Controls how much cloud puffs are depicted (lower numbers produce more cloud puffs).
	setData(findDataref("sim/private/controls/clouds/overdraw_control"), 0.1, true)

	-- Increase clouds radius
	setData(findDataref("sim/private/controls/clouds/plot_radius"), 2.2, true)

	--Object (OBJ) Bias LOD. This will decide how much detail to give objects, and from how far away these details will still be drawn.  5 (low setting) to 1 (high setting)
	setData(findDataref("sim/private/controls/reno/LOD_bias_rat"), 2, true)

	--HDR. 0 (off) or 1 (on)
	setData(findDataref("sim/private/controls/reno/draw_HDR"), 1.00, false)

	
   do_once=true
   end
end
  --3400,1370,1,0,0,0,2048,1,1,0.1,1,0,1,0,0,0,0,0,0,0,0.6,0.72,0.72,10000,0.75,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

do_often("apply_settings()")