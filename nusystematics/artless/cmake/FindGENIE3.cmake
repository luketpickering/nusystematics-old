include(FindPackageHandleStandardArgs)

SET(GENIE $ENV{GENIE})
SET(GENIE_REWEIGHT $ENV{GENIE_REWEIGHT})

find_path(GENIE3_INC_DIR
  NAMES Framework/EventGen/EventRecord.h
  PATHS ${GENIE}/include/GENIE)

find_path(GENIE3_LIB_DIR
  NAMES libGFwEG.so
  PATHS ${GENIE}/lib
)

execute_process (COMMAND genie-config
  --version OUTPUT_VARIABLE 
  GENIE_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE)

find_package_handle_standard_args(GENIE3
  REQUIRED_VARS GENIE GENIE_REWEIGHT GENIE3_INC_DIR GENIE3_LIB_DIR GENIE_VERSION
)

if(GENIE3_FOUND)

  include(ParseConfigApps)

  GetLibs(CONFIG_APP genie-config ARGS --libs OUTPUT_VARIABLE GENIE3_LIBS)

  SET(GENIE3_LIB_DIRS ${GENIE3_LIB_DIR})
  if(DEFINED EXTRA_GENIE_LIBDIRS)
    string(REPLACE "," ";" EXTRA_GENIE_LIBDIRS_LIST ${EXTRA_GENIE_LIBDIRS})
    foreach(LIBDIR ${EXTRA_GENIE_LIBDIRS_LIST})
      LIST(APPEND GENIE3_LIB_DIRS ${LIBDIR})
    endforeach()
  endif()

  cmessage(STATUS "GENIE 3")
  cmessage(STATUS "        GENIE: ${GENIE}")
  cmessage(STATUS "     LIB_DIRS: ${GENIE3_LIB_DIRS}")
  cmessage(STATUS "     INC_DIRS: ${GENIE3_INC_DIR}")
  cmessage(STATUS "         LIBS: ${GENIE3_LIBS}")

  if(NOT TARGET GENIE3::All)
    add_library(GENIE3::All INTERFACE IMPORTED)
    set_target_properties(GENIE3::All PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${GENIE3_INC_DIR}"
        INTERFACE_LINK_DIRECTORIES "${GENIE3_LIB_DIRS}"
        INTERFACE_LINK_LIBRARIES "GRwFwk;GRwClc;GRwIO;${GENIE3_LIBS};Geom;EG;EGPythia6;GenVector;ROOT::ROOT;xml2;log4cpp"
    )
  endif()
endif()
