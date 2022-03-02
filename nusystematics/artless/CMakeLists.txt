include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/nusystematicsConfig.cmake)

####### utility library
SET(utility_HDRFILES
  ${CMAKE_SOURCE_DIR}/nusystematics/utility/enumclass2int.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/utility/exceptions.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/utility/GENIEUtils.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/utility/simbUtility.hh)

INSTALL(FILES ${utility_HDRFILES} 
  DESTINATION include/nusystematics/utility)

####### responsecalculators library
SET(responsecalculators_HDRFILES
  ${CMAKE_SOURCE_DIR}/nusystematics/responsecalculators/BeRPA.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/responsecalculators/TemplateResponseCalculatorBase.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/responsecalculators/MKSinglePiTemplate_ReWeight.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/responsecalculators/MINERvA2p2hq0q3.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/responsecalculators/MINERvAq0q3Weighting_data.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/responsecalculators/MINERvARPAq0q3_ReWeight.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/responsecalculators/EnuBinnedTemplateResponseCalculator.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/responsecalculators/FSILikeEAvailSmearing.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/responsecalculators/nuenuebar_xsec_ratio.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/responsecalculators/nuenumu_xsec_ratio.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/responsecalculators/SPPLowQ2Suppression.hh)

INSTALL(FILES ${responsecalculators_HDRFILES} 
  DESTINATION include/nusystematics/responsecalculators)

####### interface
INSTALL(FILES ${CMAKE_SOURCE_DIR}/nusystematics/interface/IGENIESystProvider_tool.hh 
        DESTINATION include/nusystematics/interface)

####### response_helper
INSTALL(FILES ${CMAKE_SOURCE_DIR}/nusystematics/artless/response_helper.hh
              ${CMAKE_SOURCE_DIR}/nusystematics/artless/make_instance.hh
        DESTINATION include/nusystematics/artless)

####### systproviders library
SET(systproviders_IMPLFILES
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/GENIEReWeight_tool.cc
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/GENIEReWeightEngineConfig.cc
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/GENIEReWeightParamConfig.cc
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/MKSinglePiTemplate_tool.cc
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/MINERvAq0q3Weighting_tool.cc
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/NOvAStyleNonResPionNorm_tool.cc
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/BeRPAWeight_tool.cc
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/MiscInteractionSysts_tool.cc
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/MINERvAE2p2h_tool.cc
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/EbLepMomShift_tool.cc
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/FSILikeEAvailSmearing_tool.cc
)

SET(systproviders_HDRFILES
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/GENIEReWeight_tool.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/MKSinglePiTemplate_tool.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/MINERvAq0q3Weighting_tool.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/GENIEResponseParameterAssociation.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/NOvAStyleNonResPionNorm_tool.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/BeRPAWeight_tool.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/MiscInteractionSysts_tool.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/MINERvAE2p2h_tool.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/EbLepMomShift_tool.hh
  ${CMAKE_SOURCE_DIR}/nusystematics/systproviders/FSILikeEAvailSmearing_tool.hh
)

add_library(nusystematics_systproviders SHARED ${systproviders_IMPLFILES})
set_target_properties(nusystematics_systproviders PROPERTIES 
  PUBLIC_HEADER "${systproviders_HDRFILES}"
  EXPORT_NAME systproviders)

target_link_libraries(nusystematics_systproviders systematicstools::all GENIE3::All)

install(TARGETS nusystematics_systproviders 
    EXPORT nusystematics-targets
    LIBRARY DESTINATION lib/
    PUBLIC_HEADER DESTINATION include/nusystematics/systproviders)

##### CMake
install(EXPORT nusystematics-targets
  FILE nusystematicsTargets.cmake
  NAMESPACE nusystematics::
  DESTINATION ${CMAKE_INSTALL_PREFIX}/cmake
)

install(FILES
  ${CMAKE_CURRENT_SOURCE_DIR}/cmake/nusystematicsConfig.cmake
  ${CMAKE_CURRENT_SOURCE_DIR}/cmake/FindGENIE3.cmake
  ${CMAKE_CURRENT_SOURCE_DIR}/cmake/parseConfigApp.cmake 
  DESTINATION cmake)

FILE(WRITE ${CMAKE_INSTALL_PREFIX}/cmake/nusystematicsVersion.cmake 
  "SET(nusystematics_VERSION ${nusystematics_VERSION})\n" )

####### fhicl files
file(GLOB FCL ${CMAKE_SOURCE_DIR}/nusystematics/fcl/*.fcl)
install(FILES ${FCL} DESTINATION ${CMAKE_INSTALL_PREFIX}/fcl)

####### environment scripts
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/setup.sh.in
  "${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/setup.sh" @ONLY)
install(FILES
  "${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/setup.sh" DESTINATION
  ${CMAKE_INSTALL_PREFIX})
