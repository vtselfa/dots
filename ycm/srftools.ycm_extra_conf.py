import os

def Settings( **kwargs ):
    workarea = os.environ["WORKAREA"]
    chipname = os.environ["CHIPNAME"] # S9 / S9m
    return {
        'flags': [
            '-x',
            'c++',
            "-Wall",
            "-std c++11",
            "-Wextra",
            "-Wno-parentheses",
            "-Wno-unused-parameter",
            "-DBOOST_ALL_NO_LIB",
            "-DBOOST_LOG_DYN_LINK",
            "-DISCTLM_NOWARN_DEPRECATED_SCBTLM=1",
            "-DPROJECT_NAME=" + chipname.upper(),
            "-DPROJECT_" + chipname.upper(),
            "-DSC_CPLUSPLUS=199711L",
            "-DSC_INCLUDE_DYNAMIC_PROCESSES",
            "-DSC_INCLUDE_FX",
            "-DUSE_SYSTEMVP",
            "-I.",
            "-I" + workarea + "/srftools/lib/sc/build_info/beh",
            "-I" + workarea + "/srftools/lib/sc/calibration_utils/beh",
            "-I" + workarea + "/srftools/lib/sc/interfaces/beh",
            "-I" + workarea + "/srftools/lib/sc/lookup/beh",
            "-I" + workarea + "/srftools/lib/sc/meta_utils/beh",
            "-I" + workarea + "/srftools/lib/sc/mixed_abstraction_utils/beh",
            "-I" + workarea + "/srftools/lib/sc/noc_utils/beh",
            "-I" + workarea + "/srftools/lib/sc/scon_utils/beh",
            "-I" + workarea + "/srftools/lib/sc/tb_utils/beh",
            "-I" + workarea + "/srftools/lib/sc/tlm4rf/beh",
            "-I" + workarea + "/srftools/lib/sc/utils/beh",
            "-I" + workarea + "/srftools/lib/sc/wri_utils/beh",
            "-I" + workarea + "/top/lib/as/src",
            "-I" + workarea + "/tx/units/xml_gen/arm",
            "-I" + workarea + "/tx/units/xml_gen/c",
            "-isystem",
            "/p/inway/eda/opensource/systemc/2.3.1/systemc-2.3.1/inst/include",
            "-isystem",
            "/p/inway/tools/opensource/boost/1.57.0/share/include",
            "-isystem",
            workarea + "/resources/isctlm/incl",
            "-isystem",
            workarea + "/resources/isctlm/incl/scb_utils/",
        ]
    }

