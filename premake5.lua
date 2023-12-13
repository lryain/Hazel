include "Dependencies.lua"
workspace "Hazel"
	architecture "x64"

	configurations{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["GLAD"] = "Hazel/vendor/GLAD/include"
include "Hazel/vendor/GLAD"

IncludeDir["GLFW"] = "Hazel/vendor/GLFW/include"
include "Hazel/vendor/GLFW"

IncludeDir["IMGUI"] = "Hazel/vendor/IMGUI"
include "Hazel/vendor/IMGUI"

project "Hazel"
	location "Hazel"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "hzpch.h"
	pchsource "Hazel/src/hzpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs{
		"%{prj.name}/vendor/spdlog/include",
		"%{prj.name}/src",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.GLAD}",
		"%{IncludeDir.IMGUI}",
	}

	links{
		"GLFW",
		"GLAD",
		"IMGUI",
		"opengl32.lib",
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}

		filter "configurations:Debug"
			defines "HZ_DEBUG"
			buildoptions "/MDd"
			symbols "On"

		filter "configurations:Release"
			defines "HZ_RELEASE"
			buildoptions "/MD"
			symbols "On"

		filter "configurations:Dist"
			defines "HZ_DIST"
			buildoptions "/MD"
			symbols "On"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	includedirs{
		"Hazel/vendor/spdlog/include",
		"Hazel/src"
	}

	links{
		"Hazel"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
		}

		filter "configurations:Debug"
			defines "HZ_DEBUG"
			buildoptions "/MDd"
			symbols "On"

		filter "configurations:Release"
			defines "HZ_RELEASE"
			buildoptions "/MD"
			symbols "On"

		filter "configurations:Dist"
			defines "HZ_DIST"
			buildoptions "/MD"
			symbols "On"

group "Dependencies"
	include "Hazel/vendor/GLFW"
group ""