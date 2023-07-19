#pragma once

#include "nusystematics/interface/IGENIESystProvider_tool.hh"

#include "nusystematics/responsecalculators/TemplateResponseCalculatorBase.hh"

#include "TFile.h"
#include "TTree.h"

#include <memory>
#include <string>

class EbLepMomShift : public nusyst::IGENIESystProvider_tool {

  class EbTemplateResponseEnuFSLepctheta
      : public nusyst::TemplateResponse2DDiscrete {
  public:
    std::string GetCalculatorName() const {
      return "EbTemplateResponseEnuFSLepctheta";
    }
  };

public:
  explicit EbLepMomShift(fhiclsimple::ParameterSet const &);

  bool SetupResponseCalculator(fhiclsimple::ParameterSet const &);
  fhiclsimple::ParameterSet GetExtraToolOptions() { return tool_options; }

  systtools::SystMetaData BuildSystMetaData(fhiclsimple::ParameterSet const &,
                                            systtools::paramId_t);

  systtools::event_unit_response_t GetEventResponse(genie::EventRecord const &);

  std::string AsString();

  ~EbLepMomShift();

private:
  fhiclsimple::ParameterSet tool_options;

  size_t ResponseParameterIdx;

  EbTemplateResponseEnuFSLepctheta EbTemplate;

  void InitValidTree();

  bool fill_valid_tree;
  TFile *valid_file;
  TTree *valid_tree;

  int NEUTMode;
  double Enu, FSLep_pmu, FSLep_ctheta, shift;
  bool BinOutsideRange;
};
