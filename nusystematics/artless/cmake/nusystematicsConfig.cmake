if(NOT COMMAND cmessage)
  if(NOT WIN32)
    string(ASCII 27 Esc)
    set(CM_ColourReset "${Esc}[m")
    set(CM_ColourBold "${Esc}[1m")
    set(CM_Red "${Esc}[31m")
    set(CM_Green "${Esc}[32m")
    set(CM_Yellow "${Esc}[33m")
    set(CM_Blue "${Esc}[34m")
    set(CM_Magenta "${Esc}[35m")
    set(CM_Cyan "${Esc}[36m")
    set(CM_White "${Esc}[37m")
    set(CM_BoldRed "${Esc}[1;31m")
    set(CM_BoldGreen "${Esc}[1;32m")
    set(CM_BoldYellow "${Esc}[1;33m")
    set(CM_BoldBlue "${Esc}[1;34m")
    set(CM_BoldMagenta "${Esc}[1;35m")
    set(CM_BoldCyan "${Esc}[1;36m")
    set(CM_BoldWhite "${Esc}[1;37m")
  endif()

  message(STATUS "Setting up colored messages...")

  function(cmessage)
    list(GET ARGV 0 MessageType)
    if(MessageType STREQUAL FATAL_ERROR OR MessageType STREQUAL SEND_ERROR)
      list(REMOVE_AT ARGV 0)
      message(${MessageType} "${CM_BoldRed}${ARGV}${CM_ColourReset}")
    elseif(MessageType STREQUAL WARNING)
      list(REMOVE_AT ARGV 0)
      message(${MessageType} "${CM_BoldYellow}${ARGV}${CM_ColourReset}")
    elseif(MessageType STREQUAL AUTHOR_WARNING)
      list(REMOVE_AT ARGV 0)
      message(${MessageType} "${CM_BoldCyan}${ARGV}${CM_ColourReset}")
    elseif(MessageType STREQUAL STATUS)
      list(REMOVE_AT ARGV 0)
      message(${MessageType} "${CM_Green}[INFO]:${CM_ColourReset} ${ARGV}")
    elseif(MessageType STREQUAL CACHE)        
      list(REMOVE_AT ARGV 0)
      message(-- "${CM_Blue}[CACHE]:${CM_ColourReset} ${ARGV}")
    elseif(MessageType STREQUAL DEBUG)
      list(REMOVE_AT ARGV 0)
      if(BUILD_DEBUG_MSGS)
        message("${CM_Magenta}[DEBUG]:${CM_ColourReset} ${ARGV}")
      endif()
    else()
      message(${MessageType} "${CM_Green}[INFO]:${CM_ColourReset} ${ARGV}")
    endif()
  endfunction()
endif()

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

if(NOT "${CMAKE_PROJECT_NAME} " STREQUAL "nusystematics ")
  get_filename_component(nusystematics_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
  include(${nusystematics_CMAKE_DIR}/nusystematicsTargets.cmake)
  include(${nusystematics_CMAKE_DIR}/nusystematicsVersion.cmake)

  find_path(nusystematics_INCLUDE_DIR
    NAMES nusystematics/interface/types.hh
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