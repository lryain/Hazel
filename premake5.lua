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
IncludeDir["GLFW"] = "Hazel/vendor/GLFW/include"
IncludeDir["IMGUI"] = "Hazel/vendor/IMGUI"
IncludeDir["GLM"] = "Hazel/vendor/GLM"


include "Hazel/vendor/GLAD"
include "Hazel/vendor/GLFW"
include "Hazel/vendor/IMGUI"


project "Hazel"
	location "Hazel"
	kind "StaticLib"
	staticruntime "on"
	language "C++"
	cppdialect "C++17"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "hzpch.h"
	pchsource "Hazel/src/hzpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/vendor/glm/glm/**.hpp",
		"%{prj.name}/vendor/glm/glm/**.inl",
	}

	defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}

	includedirs{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.GLAD}",
		"%{IncludeDir.IMGUI}",
		"%{IncludeDir.GLM}",
	}

	links{
		"GLFW",
		"GLAD",
		"IMGUI",
		"opengl32.lib",
	}

	filter "system:windows"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

		filter "configurations:Debug"
			defines "HZ_DEBUG"
			symbols "on"

		filter "configurations:Release"
			defines "HZ_RELEASE"
			symbols "on"

		filter "configurations:Dist"
			defines "HZ_DIST"
			symbols "on"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	includedirs{
		"Hazel/src",
		"Hazel/vendor/spdlog/include",
		"Hazel/vendor",
		"%{IncludeDir.GLM}",
	}

	links{
		"Hazel"
	}

	filter "system:windows"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
		}

		filter "configurations:Debug"
			defines "HZ_DEBUG"
			runtime "Debug"
			symbols "on"

		filter "configurations:Release"
			defines "HZ_RELEASE"
			runtime "Release"
			optimize "on"

		filter "configurations:Dist"
			defines "HZ_DIST"
			runtime "Release"
			optimize "on"

group "Dependencies"
	include "Hazel/vendor/GLFW"
group ""