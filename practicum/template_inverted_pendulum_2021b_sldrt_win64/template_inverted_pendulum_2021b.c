/*
 * template_inverted_pendulum_2021b.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "template_inverted_pendulum_2021b".
 *
 * Model version              : 8.3
 * Simulink Coder version : 9.6 (R2021b) 14-May-2021
 * C source code generated on : Thu May 12 15:12:45 2022
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "template_inverted_pendulum_2021b.h"
#include "template_inverted_pendulum_2021b_private.h"
#include "template_inverted_pendulum_2021b_dt.h"

/* options for Simulink Desktop Real-Time board 0 */
static double SLDRTBoardOptions0[] = {
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
};

/* list of Simulink Desktop Real-Time timers */
const int SLDRTTimerCount = 1;
const double SLDRTTimers[2] = {
  0.005, 0.0,
};

/* list of Simulink Desktop Real-Time boards */
const int SLDRTBoardCount = 1;
SLDRTBOARD SLDRTBoards[1] = {
  { "National_Instruments/PCI-6014", 4294967295U, 6, SLDRTBoardOptions0 },
};

/* Block signals (default storage) */
B_template_inverted_pendulum_2021b_T template_inverted_pendulum_2021b_B;

/* Block states (default storage) */
DW_template_inverted_pendulum_2021b_T template_inverted_pendulum_2021b_DW;

/* Real-time model */
static RT_MODEL_template_inverted_pendulum_2021b_T
  template_inverted_pendulum_2021b_M_;
RT_MODEL_template_inverted_pendulum_2021b_T *const
  template_inverted_pendulum_2021b_M = &template_inverted_pendulum_2021b_M_;
static void rate_scheduler(void);

/*
 *         This function updates active task flag for each subrate.
 *         The function is called at model base rate, hence the
 *         generated code self-manages all its subrates.
 */
static void rate_scheduler(void)
{
  /* Compute which subrates run during the next base time step.  Subrates
   * are an integer multiple of the base rate counter.  Therefore, the subtask
   * counter is reset when it reaches its limit (zero means run).
   */
  (template_inverted_pendulum_2021b_M->Timing.TaskCounters.TID[1])++;
  if ((template_inverted_pendulum_2021b_M->Timing.TaskCounters.TID[1]) > 49) {/* Sample time: [0.25s, 0.0s] */
    template_inverted_pendulum_2021b_M->Timing.TaskCounters.TID[1] = 0;
  }

  template_inverted_pendulum_2021b_M->Timing.sampleHits[1] =
    (template_inverted_pendulum_2021b_M->Timing.TaskCounters.TID[1] == 0) ? 1 :
    0;
}

/* Model output function */
void template_inverted_pendulum_2021b_output(void)
{
  real_T rtb_Divide_l[2];
  real_T rtb_Add1;
  real_T rtb_Add2;
  real_T rtb_Sum3;

  /* S-Function (sldrtai): '<S1>/Analog Input' */
  /* S-Function Block: <S1>/Analog Input */
  {
    ANALOGIOPARM parm;
    parm.mode = (RANGEMODE)
      template_inverted_pendulum_2021b_P.AnalogInput_RangeMode;
    parm.rangeidx = template_inverted_pendulum_2021b_P.AnalogInput_VoltRange;
    RTBIO_DriverIO(0, ANALOGINPUT, IOREAD, 2,
                   template_inverted_pendulum_2021b_P.AnalogInput_Channels,
                   &rtb_Divide_l[0], &parm);
  }

  /* Sum: '<S1>/Add2' incorporates:
   *  Constant: '<S1>/Offset_x (volts)'
   */
  rtb_Add2 =
    template_inverted_pendulum_2021b_P.AnalogInputsInvertedPendulum_offset_x +
    rtb_Divide_l[0];

  /* Gain: '<S1>/Convertion actor' */
  template_inverted_pendulum_2021b_B.Convertionactor =
    template_inverted_pendulum_2021b_P.AnalogInputsInvertedPendulum_v2m *
    rtb_Add2;

  /* Sum: '<S1>/Add1' incorporates:
   *  Constant: '<S1>/Offset_alfa (volt)'
   */
  rtb_Add1 = rtb_Divide_l[1] +
    template_inverted_pendulum_2021b_P.AnalogInputsInvertedPendulum_offset_alfa;

  /* Gain: '<S1>/Convertion ' */
  template_inverted_pendulum_2021b_B.Convertion =
    template_inverted_pendulum_2021b_P.AnalogInputsInvertedPendulum_v2r *
    rtb_Add1;

  /* Product: '<S4>/Divide' incorporates:
   *  Constant: '<S4>/Constant'
   *  Sum: '<S4>/Sum3'
   */
  rtb_Sum3 = template_inverted_pendulum_2021b_P.Wc *
    template_inverted_pendulum_2021b_P.Ts;
  rtb_Divide_l[0] = template_inverted_pendulum_2021b_B.Convertionactor *
    rtb_Sum3;
  rtb_Divide_l[1] = template_inverted_pendulum_2021b_B.Convertion * rtb_Sum3;

  /* Sum: '<S4>/Sum3' incorporates:
   *  Constant: '<S4>/Constant1'
   */
  rtb_Sum3 += template_inverted_pendulum_2021b_P.Constant1_Value;

  /* Product: '<S4>/Divide1' incorporates:
   *  Sum: '<S4>/Sum4'
   *  UnitDelay: '<S4>/Unit Delay'
   */
  template_inverted_pendulum_2021b_B.Divide1[0] =
    (template_inverted_pendulum_2021b_DW.UnitDelay_DSTATE[0] + rtb_Divide_l[0]) /
    rtb_Sum3;
  template_inverted_pendulum_2021b_B.Divide1[1] =
    (template_inverted_pendulum_2021b_DW.UnitDelay_DSTATE[1] + rtb_Divide_l[1]) /
    rtb_Sum3;

  /* ManualSwitch: '<Root>/Switch  ' */
  if (template_inverted_pendulum_2021b_P.Switch_CurrentSetting == 1) {
    /* ManualSwitch: '<Root>/Switch  ' incorporates:
     *  Constant: '<Root>/Setpoint'
     *  Constant: '<S3>/Constant'
     *  Gain: '<Root>/Gain3'
     *  Product: '<S3>/Divide'
     *  Sum: '<Root>/Sum1'
     *  Sum: '<S3>/Sum4'
     *  UnitDelay: '<S3>/Unit Delay'
     */
    template_inverted_pendulum_2021b_B.Switch =
      (((template_inverted_pendulum_2021b_B.Divide1[0] -
         template_inverted_pendulum_2021b_P.Setpoint_Value[0]) *
        -template_inverted_pendulum_2021b_P.K[0] +
        (template_inverted_pendulum_2021b_B.Divide1[1] -
         template_inverted_pendulum_2021b_P.Setpoint_Value[1]) *
        -template_inverted_pendulum_2021b_P.K[1]) +
       (template_inverted_pendulum_2021b_B.Divide1[0] -
        template_inverted_pendulum_2021b_DW.UnitDelay_DSTATE_o[0]) /
       template_inverted_pendulum_2021b_P.Ts *
       -template_inverted_pendulum_2021b_P.K[2]) +
      (template_inverted_pendulum_2021b_B.Divide1[1] -
       template_inverted_pendulum_2021b_DW.UnitDelay_DSTATE_o[1]) /
      template_inverted_pendulum_2021b_P.Ts *
      -template_inverted_pendulum_2021b_P.K[3];
  } else {
    /* ManualSwitch: '<Root>/Switch  ' incorporates:
     *  Constant: '<Root>/Off'
     */
    template_inverted_pendulum_2021b_B.Switch =
      template_inverted_pendulum_2021b_P.Off_Value;
  }

  /* End of ManualSwitch: '<Root>/Switch  ' */

  /* Saturate: '<S2>/-5v to 5v' */
  if (template_inverted_pendulum_2021b_B.Switch >
      template_inverted_pendulum_2021b_P.uvto5v_UpperSat) {
    rtb_Sum3 = template_inverted_pendulum_2021b_P.uvto5v_UpperSat;
  } else if (template_inverted_pendulum_2021b_B.Switch <
             template_inverted_pendulum_2021b_P.uvto5v_LowerSat) {
    rtb_Sum3 = template_inverted_pendulum_2021b_P.uvto5v_LowerSat;
  } else {
    rtb_Sum3 = template_inverted_pendulum_2021b_B.Switch;
  }

  /* End of Saturate: '<S2>/-5v to 5v' */

  /* Gain: '<S2>/Gain' */
  rtb_Sum3 *= template_inverted_pendulum_2021b_P.Gain_Gain;

  /* S-Function (sldrtao): '<S2>/Analog Output' */
  /* S-Function Block: <S2>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE)
        template_inverted_pendulum_2021b_P.AnalogOutput_RangeMode;
      parm.rangeidx = template_inverted_pendulum_2021b_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &template_inverted_pendulum_2021b_P.AnalogOutput_Channels,
                     ((real_T*) (&rtb_Sum3)), &parm);
    }
  }

  /* RateTransition: '<S1>/Rate Transition1' */
  if (template_inverted_pendulum_2021b_M->Timing.TaskCounters.TID[1] == 0) {
    template_inverted_pendulum_2021b_DW.RateTransition1_Buffer[0] =
      template_inverted_pendulum_2021b_B.Convertionactor;
    template_inverted_pendulum_2021b_DW.RateTransition1_Buffer[1] =
      template_inverted_pendulum_2021b_B.Convertion;

    /* RateTransition: '<S1>/Rate Transition' */
    template_inverted_pendulum_2021b_DW.RateTransition_Buffer[0] = rtb_Add2;
    template_inverted_pendulum_2021b_DW.RateTransition_Buffer[1] = rtb_Add1;

    /* RateTransition: '<S1>/Rate Transition1' */
    template_inverted_pendulum_2021b_B.RateTransition1[0] =
      template_inverted_pendulum_2021b_DW.RateTransition1_Buffer[0];

    /* RateTransition: '<S1>/Rate Transition' */
    template_inverted_pendulum_2021b_B.RateTransition[0] =
      template_inverted_pendulum_2021b_DW.RateTransition_Buffer[0];

    /* RateTransition: '<S1>/Rate Transition1' */
    template_inverted_pendulum_2021b_B.RateTransition1[1] =
      template_inverted_pendulum_2021b_DW.RateTransition1_Buffer[1];

    /* RateTransition: '<S1>/Rate Transition' */
    template_inverted_pendulum_2021b_B.RateTransition[1] =
      template_inverted_pendulum_2021b_DW.RateTransition_Buffer[1];

    /* Gain: '<S5>/Gain' */
    template_inverted_pendulum_2021b_B.Gain =
      template_inverted_pendulum_2021b_P.Gain_Gain_b *
      template_inverted_pendulum_2021b_B.RateTransition1[1];
  }

  /* End of RateTransition: '<S1>/Rate Transition1' */
}

/* Model update function */
void template_inverted_pendulum_2021b_update(void)
{
  /* Update for UnitDelay: '<S4>/Unit Delay' */
  template_inverted_pendulum_2021b_DW.UnitDelay_DSTATE[0] =
    template_inverted_pendulum_2021b_B.Divide1[0];

  /* Update for UnitDelay: '<S3>/Unit Delay' */
  template_inverted_pendulum_2021b_DW.UnitDelay_DSTATE_o[0] =
    template_inverted_pendulum_2021b_B.Divide1[0];

  /* Update for UnitDelay: '<S4>/Unit Delay' */
  template_inverted_pendulum_2021b_DW.UnitDelay_DSTATE[1] =
    template_inverted_pendulum_2021b_B.Divide1[1];

  /* Update for UnitDelay: '<S3>/Unit Delay' */
  template_inverted_pendulum_2021b_DW.UnitDelay_DSTATE_o[1] =
    template_inverted_pendulum_2021b_B.Divide1[1];

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++template_inverted_pendulum_2021b_M->Timing.clockTick0)) {
    ++template_inverted_pendulum_2021b_M->Timing.clockTickH0;
  }

  template_inverted_pendulum_2021b_M->Timing.t[0] =
    template_inverted_pendulum_2021b_M->Timing.clockTick0 *
    template_inverted_pendulum_2021b_M->Timing.stepSize0 +
    template_inverted_pendulum_2021b_M->Timing.clockTickH0 *
    template_inverted_pendulum_2021b_M->Timing.stepSize0 * 4294967296.0;
  if (template_inverted_pendulum_2021b_M->Timing.TaskCounters.TID[1] == 0) {
    /* Update absolute timer for sample time: [0.25s, 0.0s] */
    /* The "clockTick1" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick1"
     * and "Timing.stepSize1". Size of "clockTick1" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick1 and the high bits
     * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++template_inverted_pendulum_2021b_M->Timing.clockTick1)) {
      ++template_inverted_pendulum_2021b_M->Timing.clockTickH1;
    }

    template_inverted_pendulum_2021b_M->Timing.t[1] =
      template_inverted_pendulum_2021b_M->Timing.clockTick1 *
      template_inverted_pendulum_2021b_M->Timing.stepSize1 +
      template_inverted_pendulum_2021b_M->Timing.clockTickH1 *
      template_inverted_pendulum_2021b_M->Timing.stepSize1 * 4294967296.0;
  }

  rate_scheduler();
}

/* Model initialize function */
void template_inverted_pendulum_2021b_initialize(void)
{
  /* Start for S-Function (sldrtao): '<S2>/Analog Output' */

  /* S-Function Block: <S2>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE)
        template_inverted_pendulum_2021b_P.AnalogOutput_RangeMode;
      parm.rangeidx = template_inverted_pendulum_2021b_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &template_inverted_pendulum_2021b_P.AnalogOutput_Channels,
                     &template_inverted_pendulum_2021b_P.AnalogOutput_InitialValue,
                     &parm);
    }
  }

  /* InitializeConditions for UnitDelay: '<S4>/Unit Delay' */
  template_inverted_pendulum_2021b_DW.UnitDelay_DSTATE[0] =
    template_inverted_pendulum_2021b_P.UnitDelay_InitialCondition;

  /* InitializeConditions for UnitDelay: '<S3>/Unit Delay' */
  template_inverted_pendulum_2021b_DW.UnitDelay_DSTATE_o[0] =
    template_inverted_pendulum_2021b_P.UnitDelay_InitialCondition_p;

  /* InitializeConditions for UnitDelay: '<S4>/Unit Delay' */
  template_inverted_pendulum_2021b_DW.UnitDelay_DSTATE[1] =
    template_inverted_pendulum_2021b_P.UnitDelay_InitialCondition;

  /* InitializeConditions for UnitDelay: '<S3>/Unit Delay' */
  template_inverted_pendulum_2021b_DW.UnitDelay_DSTATE_o[1] =
    template_inverted_pendulum_2021b_P.UnitDelay_InitialCondition_p;
}

/* Model terminate function */
void template_inverted_pendulum_2021b_terminate(void)
{
  /* Terminate for S-Function (sldrtao): '<S2>/Analog Output' */

  /* S-Function Block: <S2>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE)
        template_inverted_pendulum_2021b_P.AnalogOutput_RangeMode;
      parm.rangeidx = template_inverted_pendulum_2021b_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &template_inverted_pendulum_2021b_P.AnalogOutput_Channels,
                     &template_inverted_pendulum_2021b_P.AnalogOutput_FinalValue,
                     &parm);
    }
  }
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/
void MdlOutputs(int_T tid)
{
  template_inverted_pendulum_2021b_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  template_inverted_pendulum_2021b_update();
  UNUSED_PARAMETER(tid);
}

void MdlInitializeSizes(void)
{
}

void MdlInitializeSampleTimes(void)
{
}

void MdlInitialize(void)
{
}

void MdlStart(void)
{
  template_inverted_pendulum_2021b_initialize();
}

void MdlTerminate(void)
{
  template_inverted_pendulum_2021b_terminate();
}

/* Registration function */
RT_MODEL_template_inverted_pendulum_2021b_T *template_inverted_pendulum_2021b
  (void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)template_inverted_pendulum_2021b_M, 0,
                sizeof(RT_MODEL_template_inverted_pendulum_2021b_T));

  /* Initialize timing info */
  {
    int_T *mdlTsMap =
      template_inverted_pendulum_2021b_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "template_inverted_pendulum_2021b_M points to
       static memory which is guaranteed to be non-NULL" */
    template_inverted_pendulum_2021b_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap
      [0]);
    template_inverted_pendulum_2021b_M->Timing.sampleTimes =
      (&template_inverted_pendulum_2021b_M->Timing.sampleTimesArray[0]);
    template_inverted_pendulum_2021b_M->Timing.offsetTimes =
      (&template_inverted_pendulum_2021b_M->Timing.offsetTimesArray[0]);

    /* task periods */
    template_inverted_pendulum_2021b_M->Timing.sampleTimes[0] = (0.005);
    template_inverted_pendulum_2021b_M->Timing.sampleTimes[1] = (0.25);

    /* task offsets */
    template_inverted_pendulum_2021b_M->Timing.offsetTimes[0] = (0.0);
    template_inverted_pendulum_2021b_M->Timing.offsetTimes[1] = (0.0);
  }

  rtmSetTPtr(template_inverted_pendulum_2021b_M,
             &template_inverted_pendulum_2021b_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits =
      template_inverted_pendulum_2021b_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    template_inverted_pendulum_2021b_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(template_inverted_pendulum_2021b_M, -1);
  template_inverted_pendulum_2021b_M->Timing.stepSize0 = 0.005;
  template_inverted_pendulum_2021b_M->Timing.stepSize1 = 0.25;

  /* External mode info */
  template_inverted_pendulum_2021b_M->Sizes.checksums[0] = (3205839546U);
  template_inverted_pendulum_2021b_M->Sizes.checksums[1] = (3728708207U);
  template_inverted_pendulum_2021b_M->Sizes.checksums[2] = (603472540U);
  template_inverted_pendulum_2021b_M->Sizes.checksums[3] = (1838654031U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[3];
    template_inverted_pendulum_2021b_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    systemRan[2] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(template_inverted_pendulum_2021b_M->extModeInfo,
      &template_inverted_pendulum_2021b_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(template_inverted_pendulum_2021b_M->extModeInfo,
                        template_inverted_pendulum_2021b_M->Sizes.checksums);
    rteiSetTPtr(template_inverted_pendulum_2021b_M->extModeInfo, rtmGetTPtr
                (template_inverted_pendulum_2021b_M));
  }

  template_inverted_pendulum_2021b_M->solverInfoPtr =
    (&template_inverted_pendulum_2021b_M->solverInfo);
  template_inverted_pendulum_2021b_M->Timing.stepSize = (0.005);
  rtsiSetFixedStepSize(&template_inverted_pendulum_2021b_M->solverInfo, 0.005);
  rtsiSetSolverMode(&template_inverted_pendulum_2021b_M->solverInfo,
                    SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  template_inverted_pendulum_2021b_M->blockIO = ((void *)
    &template_inverted_pendulum_2021b_B);
  (void) memset(((void *) &template_inverted_pendulum_2021b_B), 0,
                sizeof(B_template_inverted_pendulum_2021b_T));

  /* parameters */
  template_inverted_pendulum_2021b_M->defaultParam = ((real_T *)
    &template_inverted_pendulum_2021b_P);

  /* states (dwork) */
  template_inverted_pendulum_2021b_M->dwork = ((void *)
    &template_inverted_pendulum_2021b_DW);
  (void) memset((void *)&template_inverted_pendulum_2021b_DW, 0,
                sizeof(DW_template_inverted_pendulum_2021b_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    template_inverted_pendulum_2021b_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 18;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  template_inverted_pendulum_2021b_M->Sizes.numContStates = (0);/* Number of continuous states */
  template_inverted_pendulum_2021b_M->Sizes.numY = (0);/* Number of model outputs */
  template_inverted_pendulum_2021b_M->Sizes.numU = (0);/* Number of model inputs */
  template_inverted_pendulum_2021b_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  template_inverted_pendulum_2021b_M->Sizes.numSampTimes = (2);/* Number of sample times */
  template_inverted_pendulum_2021b_M->Sizes.numBlocks = (38);/* Number of blocks */
  template_inverted_pendulum_2021b_M->Sizes.numBlockIO = (7);/* Number of block outputs */
  template_inverted_pendulum_2021b_M->Sizes.numBlockPrms = (34);/* Sum of parameter "widths" */
  return template_inverted_pendulum_2021b_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
