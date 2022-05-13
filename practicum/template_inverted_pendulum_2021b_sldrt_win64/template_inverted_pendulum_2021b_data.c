/*
 * template_inverted_pendulum_2021b_data.c
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

/* Block parameters (default storage) */
P_template_inverted_pendulum_2021b_T template_inverted_pendulum_2021b_P = {
  /* Variable: K
   * Referenced by: '<Root>/Gain3'
   */
  { -1.0000000000000007, -23.076945155359819, -9.3583245452304027,
    -3.8438577528120668 },

  /* Variable: Ts
   * Referenced by:
   *   '<S3>/Constant'
   *   '<S4>/Constant'
   */
  0.005,

  /* Variable: Wc
   * Referenced by: '<S4>/Constant'
   */
  40.840704496667314,

  /* Mask Parameter: AnalogOutput_FinalValue
   * Referenced by: '<S2>/Analog Output'
   */
  0.0,

  /* Mask Parameter: AnalogOutput_InitialValue
   * Referenced by: '<S2>/Analog Output'
   */
  0.0,

  /* Mask Parameter: AnalogInput_MaxMissedTicks
   * Referenced by: '<S1>/Analog Input'
   */
  10.0,

  /* Mask Parameter: AnalogOutput_MaxMissedTicks
   * Referenced by: '<S2>/Analog Output'
   */
  10.0,

  /* Mask Parameter: AnalogInput_YieldWhenWaiting
   * Referenced by: '<S1>/Analog Input'
   */
  0.0,

  /* Mask Parameter: AnalogOutput_YieldWhenWaiting
   * Referenced by: '<S2>/Analog Output'
   */
  0.0,

  /* Mask Parameter: AnalogInputsInvertedPendulum_offset_alfa
   * Referenced by: '<S1>/Offset_alfa (volt)'
   */
  0.17,

  /* Mask Parameter: AnalogInputsInvertedPendulum_offset_x
   * Referenced by: '<S1>/Offset_x (volts)'
   */
  0.0,

  /* Mask Parameter: AnalogInputsInvertedPendulum_v2m
   * Referenced by: '<S1>/Convertion actor'
   */
  0.1033,

  /* Mask Parameter: AnalogInputsInvertedPendulum_v2r
   * Referenced by: '<S1>/Convertion '
   */
  0.2482,

  /* Mask Parameter: AnalogInput_Channels
   * Referenced by: '<S1>/Analog Input'
   */
  { 0, 1 },

  /* Mask Parameter: AnalogOutput_Channels
   * Referenced by: '<S2>/Analog Output'
   */
  0,

  /* Mask Parameter: AnalogInput_RangeMode
   * Referenced by: '<S1>/Analog Input'
   */
  0,

  /* Mask Parameter: AnalogOutput_RangeMode
   * Referenced by: '<S2>/Analog Output'
   */
  0,

  /* Mask Parameter: AnalogInput_VoltRange
   * Referenced by: '<S1>/Analog Input'
   */
  0,

  /* Mask Parameter: AnalogOutput_VoltRange
   * Referenced by: '<S2>/Analog Output'
   */
  0,

  /* Expression: [0 0]
   * Referenced by: '<Root>/Setpoint'
   */
  { 0.0, 0.0 },

  /* Expression: 0
   * Referenced by: '<Root>/Off'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S4>/Unit Delay'
   */
  0.0,

  /* Expression: 1
   * Referenced by: '<S4>/Constant1'
   */
  1.0,

  /* Expression: 0
   * Referenced by: '<S3>/Unit Delay'
   */
  0.0,

  /* Expression: 5
   * Referenced by: '<S2>/-5v to 5v'
   */
  5.0,

  /* Expression: -5
   * Referenced by: '<S2>/-5v to 5v'
   */
  -5.0,

  /* Expression: -1
   * Referenced by: '<S2>/Gain'
   */
  -1.0,

  /* Expression: 180/pi
   * Referenced by: '<S5>/Gain'
   */
  57.295779513082323,

  /* Computed Parameter: Switch_CurrentSetting
   * Referenced by: '<Root>/Switch  '
   */
  1U
};
