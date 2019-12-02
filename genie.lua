BASE_DIR   = path.getabsolute(".")
BUILD_PATH = path.join(BASE_DIR, "build")

solution "test"
	flags { "Cpp17" }
	location(path.join(BUILD_PATH, "src", _ACTION))
	targetdir(path.join(BUILD_PATH, "bin"))
	libdirs {
		"src/libs/glad",
		"src/libs/glfw",
	}

	configurations {
		"Release",
		"Debug"
	}
	
	platforms {
		"Native",
	}
	platforms { "x64" }
	buildoptions_cpp {
	}

	linkoptions {
	}

	configuration "Debug"
		flags       { "Symbols" }
		defines     {  }
		
	configuration "Release"
		flags       { "OptimizeSize" }
	
	
project "arc"
  	language "C++"
  	kind     "StaticLib"
	links { 
		"glad",
		"glfw"
	}

  	files {
  		"src/arc/**.cpp",
  	}
	
  	includedirs {
  		"src/arc/",
  		"src/libs/glad/include",
  		"src/libs/glfw/include"
  	}
	
project "sample_0"
  	language "C++"
  	kind     "ConsoleApp"
	
	links { 
		"arc",
		"glad",
		"glfw"
	}
  	files {
  		"src/samples/01_hello/**.cpp",
  	}
	
  	includedirs {
  		"src/samples/01_hello/",
  		"src/arc/",
  		"src/libs/glad/include",
  		"src/libs/glfw/include"
  	}
		
function defaultConfigurations()
	configuration "Debug"
		targetdir(BINARY_DIR .. "Debug")
		defines { "NDEBUG", "LUMIX_DEBUG" }
		flags { "Symbols", "ReleaseRuntime", "WinMain" }

	configuration "RelWithDebInfo"
		targetdir(BINARY_DIR .. "RelWithDebInfo")
		defines { "NDEBUG" }
		flags { "Symbols", "Optimize", "WinMain" }

	configuration "linux"
		buildoptions { "-std=c++14" }
		defines { "_GLIBCXX_USE_CXX11_ABI=0" }
		links { "pthread" }

	configuration { "vs20*"}
		buildoptions { "/wd4503"}
		
	configuration {}
		files { "lumix.natvis", "../.editorconfig" }
		defines { "_ITERATOR_DEBUG_LEVEL=0" }
end