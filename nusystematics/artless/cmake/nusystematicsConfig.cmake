include(CMessage)

if(NOT "${CMAKE_PROJECT_NAME} " STREQUAL "nusystematics ")
  get_filename_component(nusystematics_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
  list(APPEND CMAKE_MODULE_PATH "${nusystematics_CMAKE_DIR}")
else()
  list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
endif()

cmessage(STATUS "CMAKE_MODULE_PATH: ${CMAKE_MODULE_PATH}")

find_package(systematicstools REQUIRED)

###### GENIE setup
find_package(GENIE3 REQUIRED)

if(DEFINED ROOT_CXX_STANDARD)
  if(NOT DEFINED CMAKE_CXX_STANDARD OR ROOT_CXX_STANDARD GREATER CMAKE_CXX_STANDARD)
    set(CMAKE_CXX_STANDARD ${ROOT_CXX_STANDARD})
  endif()
endif()

if(NOT "${CMAKE_PROJECT_NAME} " STREQUAL "nusystematics ")
  get_filename_component(nusystematics_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
  include(${nusystematics_CMAKE_DIR}/nusystematicsTargets.cmake)
  include(${nusystematics_CMAKE_DIR}/nusystematicsVersion.cmake)

  find_path(nusystematics_INCLUDE_DIR
    NAMES nusystematics/interface/IGENIESystProvider_tool.hh
    PATHS ${nusystematics_CMAKE_DIR}/../include
  )

  cmessage(STATUS "nusystematics_INCLUDE_DIR: ${nusystematics_INCLUDE_DIR}")
  cmessage(STATUS "nusystematics_VERSION: ${nusystematics_VERSION}")

  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(nusystematics
      REQUIRED_VARS 
        nusystematics_INCLUDE_DIR
      VERSION_VAR 
        nusystematics_VERSION
  )
  if(NOT TARGET nusystematics::all)
      add_library(nusystematics::all INTERFACE IMPORTED)
      set_target_properties(nusystematics::all PROPERTIES
          INTERFACE_INCLUDE_DIRECTORIES ${nusystematics_INCLUDE_DIR}
          INTERFACE_LINK_LIBRARIES 
            "nusystematics::systproviders"
      )
  endif()
endif()