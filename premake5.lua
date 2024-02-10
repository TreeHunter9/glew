project "GLEW"
	kind "StaticLib"
	language "C"

	targetdir ( "bin/" .. outputdir .. "/%{prj.name}" )
	objdir ( "bin-obj/" .. outputdir .. "/%{prj.name}" )

	files
	{ 
		"src/*.c",
		"include/GL/*.h"
	}

	includedirs
	{
		"include"
	}

	filter "configurations:Debug"
		defines { "DEBUG" }
		symbols "On"

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "On"

	filter "configurations:Dist"
		defines { "NDEBUG" }
		optimize "On"
		symbols "Off"