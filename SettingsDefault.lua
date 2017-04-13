local start_time = os.clock()
local do_once = false

function save_default_settings()
	
	DataRef( "AURORA_BOREALIS", "sim/private/controls/reno/draw_aurora" )
	DataRef( "CARRIERS_FRIGATES", "sim/private/controls/reno/draw_boats" )
	DataRef( "BIRDS_DEER", "sim/private/controls/reno/draw_deer_birds" )
	DataRef( "FIRES_BALOONS", "sim/private/controls/reno/draw_fire_ball" )
	DataRef( "DISTANCE_TRAFFIC", "sim/private/controls/cars/lod_min" )
	DataRef( "DISTANCE_PLANS", "sim/private/controls/park/static_plane_build_dis" )
	DataRef( "RUNWAYS_CONTOURS", "sim/private/controls/reno/sloped_runways" )
	DataRef( "ATMOSPHERIC_SCATTERING", "sim/private/controls/reno/draw_scattering" )
	DataRef( "VOLUMETRIC_FOG", "sim/private/controls/reno/draw_volume_fog01" )
	DataRef( "PIXEL_LIGHTING", "sim/private/controls/reno/draw_per_pix_liting" )
	DataRef( "OBJECT_DENSITY", "sim/private/controls/reno/draw_objs_06" )
	DataRef( "TRAFFIC_DENSITY", "sim/private/controls/reno/draw_cars_05" )
	DataRef( "ROAD_DENSITY", "sim/private/controls/reno/draw_vecs_03" )
	DataRef( "TAXIWAY_SMOOTHNESS", "sim/private/controls/reno/draw_detail_apt_03" )
	DataRef( "FOREST_DENSITY", "sim/private/controls/reno/draw_for_05" )
	DataRef( "FOREST_INNER", "sim/private/controls/forest/inn_ring_density" )
	DataRef( "FOREST_MID", "sim/private/controls/forest/mid_ring_density" )
	DataRef( "FOREST_OUTER", "sim/private/controls/forest/out_ring_density" )
	DataRef( "FADE_RATE", "sim/private/controls/terrain/fade_start_rat" )
	DataRef( "LOD_BIAS", "sim/private/controls/ag/tile_lod_bias" )
	DataRef( "DISTANCE_BIAS", "sim/private/controls/terrain/composite_far_dist_bias" )
	DataRef( "WATER_REFLECTION", "sim/private/controls/reno/draw_reflect_water05" )
	DataRef( "COMPRESS_TEXTURES", "sim/private/controls/reno/comp_texes" )
	DataRef( "BUMPMAP_TEXTURES", "sim/private/controls/reno/use_bump_maps" )
	DataRef( "DETAIL_TEXTURES", "sim/private/controls/reno/use_detail_textures" )
	DataRef( "AMBIENT_OCCLUSION", "sim/private/controls/ssao/enable" )
	DataRef( "STATIC_PLANE_DENSITY", "sim/private/controls/park/static_plane_density" )
	DataRef( "SHADOW_EXTERIOR", "sim/private/controls/shadow/csm_split_exterior" )
	DataRef( "SHADOW_FADE", "sim/private/controls/shadow/csm/far_limit" )
	DataRef( "SHADOW_SIZE", "sim/private/controls/fbo/shadow_cam_size" )
	DataRef( "GROUND_VISIBLE", "sim/private/controls/skyc/max_dsf_vis_ever" )
	DataRef( "GROUND_FADING", "sim/private/controls/skyc/dsf_fade_ratio" )
	DataRef( "REFLECTIVE_WATER", "sim/private/controls/caps/use_reflective_water" )
	DataRef( "FFT_WATER", "sim/private/controls/reno/draw_fft_water" )
	DataRef( "COCKPIT_PROXY", "sim/private/controls/shadow/cockpit_near_proxy" )
	DataRef( "COCKPIT_NEAR", "sim/private/controls/shadow/cockpit_near_adjust" )
	DataRef( "CLOUD_PUFFS", "sim/private/controls/clouds/overdraw_control" )
	DataRef( "CLOUDS_RADIUS", "sim/private/controls/clouds/plot_radius" )
	

	defaultfile = os.open(SCRIPT_DIRECTORY .. "default_settings.txt", "w")
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
end


function apply_settings()
    if os.clock() > start_time and do_once == false then
	
	save_default_settings()

	--Draw Aurora Borealis. 0 (off) or 1 (on)
	set( "sim/private/controls/reno/draw_aurora", 1.00)

	--Draw aircraft carriers and frigates. 0 (off) or 1 (on)
	set( "sim/private/controls/reno/draw_boats", 1.00)

	--Draw birds and deer in nice weather. 0 (off) or 1 (on)
	set( "sim/private/controls/reno/draw_deer_birds", 1.00)

	--Draw fires and baloons. 0 (off) or 1 (on)
	set( "sim/private/controls/reno/draw_fire_ball", 1.00)

	--Distance at which road traffic is visible. Default is 20000 meters. Recommend 7500.
	set( "sim/private/controls/cars/lod_min", 7500.00)

	--Distance at which static plans are visible. Default is 9260 meters. Recommend 3000.
	set( "sim/private/controls/park/static_plane_build_dis", 3000.00)

	--Runways follow terrain contours. 0 (off) or 1 (on)
	set( "sim/private/controls/reno/sloped_runways", 1.00)

	--Atmospheric scattering. 0 (off) or 1 (on)
	set( "sim/private/controls/reno/draw_scattering", 1.00)

	--Draw volumetric fog. 0 (off) or 1 (on)
	set( "sim/private/controls/reno/draw_volume_fog01", 1.00)

	--Draw per pixel lighting. 0 (off) or 1 (on). Change both of the settings below to be the same.
	set( "sim/private/controls/reno/draw_per_pix_liting", 1.00)

	--3D Object Density. 0 (None) to 6 (Extreme)
	set( "sim/private/controls/reno/draw_objs_06", 6.00)

	--Road traffic density. 0 (off) to 5 (very dense)
	set( "sim/private/controls/reno/draw_cars_05", 4.00)

	--Road Density. 0 (None) to 3 (Extreme)
	set( "sim/private/controls/reno/draw_vecs_03", 2.00)

	--Runway and taxiway line smoothness and 3D runway/taxiway lighting. 0 (Low) to 3 (Extreme)
	set( "sim/private/controls/reno/draw_detail_apt_03", 2.00)

	--Forest density. 0 (Low) to 5 (Extreme)
	set( "sim/private/controls/reno/draw_for_05", 4.00)

	--Forest inner ring density. 0 (0%) to 1 (100%)
	set( "sim/private/controls/forest/inn_ring_density", 0.50)

	--Forest mid ring density. 0 (0%) to 1 (100%)
	set( "sim/private/controls/forest/mid_ring_density", 0.75)

	--Forest outer ring density. 0 (0%) to 1 (100%)
	set( "sim/private/controls/forest/out_ring_density", 1.00)

	--Fade start rate. 0.75 (low setting) to 0.6 (high setting)
	set( "sim/private/controls/terrain/fade_start_rat", 0.70)

	--Tile LOD bias. 0.72 (low setting) to 1.0 (high setting)
	set( "sim/private/controls/ag/tile_lod_bias", 0.83)

	--Composite far distance bias. 0.72 (low setting) to 1.0 (high setting)
	set( "sim/private/controls/terrain/composite_far_dist_bias", 0.83)

	--Water reflection detail. 0 (None) to 5 (Complete)
	set( "sim/private/controls/reno/draw_reflect_water05", 0.00)

	--Compress textures to save VRAM. 0 (off) or 1 (on)
	set( "sim/private/controls/reno/comp_texes", 1.00)

	--Use bump map textures. 0 (off) or 1 (on)
	set( "sim/private/controls/reno/use_bump_maps", 1.00)

	--Use detail (aka gritty) textures or decals. 0 (off) or 1 (on)
	set( "sim/private/controls/reno/use_detail_textures", 1.00)

	--Ambient Occlusion. 0 (off) or 1 (on)
	set( "sim/private/controls/ssao/enable", 1.00)

	--Static plane density. 1 (low) to 6 (high). Note this does not affect static planes manually placed by scenery designer, just the ones that automatically appear and start areas.
	set( "sim/private/controls/park/static_plane_density", 3.00)

	--Cascading Shadow Maps Exterior Quality (Higher numbers reduce jagged edges of shadows). Known valid values are 1 or 2 for XP11.  XP10 used values of 0-5.
	set( "sim/private/controls/shadow/csm_split_exterior", 2.00)

	--Shadow fade distance. XP11 uses values ranging from 500 to 1500.  XP10 used values ranging from 500 to 6000.
	set( "sim/private/controls/shadow/csm/far_limit", 1000.00)

	--Shadow texture size??? XP11 uses either 2048 or 4096. This setting was not used in XP10
	set( "sim/private/controls/fbo/shadow_cam_size", 4096.00)

	--The following values adjust the maximum distance ground scenery is visible.  Default is 10000.  Larger values seem to have no affect, but you might try lower values if you have a low end system.
	set( "sim/private/controls/skyc/max_dsf_vis_ever", 100000.00)

	--The following values adjust fading of ground textures in the distance.  Default is 0.90 in XP10 (0.75 in XP 11).  Higher values have no effect.  But you might try lower values (0.10 for example) if you want the ground scenery to fade to brown more gradually in the distance.
	set( "sim/private/controls/skyc/dsf_fade_ratio", 0.90)

	--The following enables reflective water. Default is 1.00 (on)
	set( "sim/private/controls/caps/use_reflective_water", 1.00)
	
	-- Draw fft water
	set( "sim/private/controls/reno/draw_fft_water", 1.00)

	-- Cockpit near Proxy
	set( "sim/private/controls/shadow/cockpit_near_proxy", 3.00)

	-- Cockpit near adjust
	set( "sim/private/controls/shadow/cockpit_near_adjust", 1.00)

	-- Controls how much cloud puffs are depicted (lower numbers produce more cloud puffs).
	set( "sim/private/controls/clouds/overdraw_control", 0.50)

	-- Increase clouds radius
	set( "sim/private/controls/clouds/plot_radius", 2.00)
	
	do_once=true
    end
end


do_often("apply_settings()")

