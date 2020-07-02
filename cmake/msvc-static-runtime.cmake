option(BUILD_LINK_WITH_STATIC_RUNTIME "Use static linking of msvc runtime" ON)

# msvcrt runtime linking
# ------------------------------------------------------------------------------
if (MSVC)
	if (BUILD_SHARED_LIBS AND BUILD_LINK_WITH_STATIC_RUNTIME)
		message(STATUS "Turning off MSVC static runtime due to shared library build")
		set(BUILD_LINK_WITH_STATIC_RUNTIME OFF)
	endif()

	if (BUILD_LINK_WITH_STATIC_RUNTIME)
		# switch from dynamic to static linking of msvcrt
		foreach(flag_var
			CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
			CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)

			if(${flag_var} MATCHES "/MD")
				string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
			endif(${flag_var} MATCHES "/MD")
		endforeach(flag_var)
	endif()
endif()
# ------------------------------------------------------------------------------
