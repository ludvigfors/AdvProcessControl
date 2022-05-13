    function targMap = targDataMap(),

    ;%***********************
    ;% Create Parameter Map *
    ;%***********************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 4;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc paramMap
        ;%
        paramMap.nSections           = nTotSects;
        paramMap.sectIdxOffset       = sectIdxOffset;
            paramMap.sections(nTotSects) = dumSection; %prealloc
        paramMap.nTotData            = -1;

        ;%
        ;% Auto data (template_inverted_pendulum_2021b_P)
        ;%
            section.nData     = 13;
            section.data(13)  = dumData; %prealloc

                    ;% template_inverted_pendulum_2021b_P.K
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% template_inverted_pendulum_2021b_P.Ts
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 4;

                    ;% template_inverted_pendulum_2021b_P.Wc
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 5;

                    ;% template_inverted_pendulum_2021b_P.AnalogOutput_FinalValue
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 6;

                    ;% template_inverted_pendulum_2021b_P.AnalogOutput_InitialValue
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 7;

                    ;% template_inverted_pendulum_2021b_P.AnalogInput_MaxMissedTicks
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 8;

                    ;% template_inverted_pendulum_2021b_P.AnalogOutput_MaxMissedTicks
                    section.data(7).logicalSrcIdx = 6;
                    section.data(7).dtTransOffset = 9;

                    ;% template_inverted_pendulum_2021b_P.AnalogInput_YieldWhenWaiting
                    section.data(8).logicalSrcIdx = 7;
                    section.data(8).dtTransOffset = 10;

                    ;% template_inverted_pendulum_2021b_P.AnalogOutput_YieldWhenWaiting
                    section.data(9).logicalSrcIdx = 8;
                    section.data(9).dtTransOffset = 11;

                    ;% template_inverted_pendulum_2021b_P.AnalogInputsInvertedPendulum_offset_alfa
                    section.data(10).logicalSrcIdx = 9;
                    section.data(10).dtTransOffset = 12;

                    ;% template_inverted_pendulum_2021b_P.AnalogInputsInvertedPendulum_offset_x
                    section.data(11).logicalSrcIdx = 10;
                    section.data(11).dtTransOffset = 13;

                    ;% template_inverted_pendulum_2021b_P.AnalogInputsInvertedPendulum_v2m
                    section.data(12).logicalSrcIdx = 11;
                    section.data(12).dtTransOffset = 14;

                    ;% template_inverted_pendulum_2021b_P.AnalogInputsInvertedPendulum_v2r
                    section.data(13).logicalSrcIdx = 12;
                    section.data(13).dtTransOffset = 15;

            nTotData = nTotData + section.nData;
            paramMap.sections(1) = section;
            clear section

            section.nData     = 6;
            section.data(6)  = dumData; %prealloc

                    ;% template_inverted_pendulum_2021b_P.AnalogInput_Channels
                    section.data(1).logicalSrcIdx = 13;
                    section.data(1).dtTransOffset = 0;

                    ;% template_inverted_pendulum_2021b_P.AnalogOutput_Channels
                    section.data(2).logicalSrcIdx = 14;
                    section.data(2).dtTransOffset = 2;

                    ;% template_inverted_pendulum_2021b_P.AnalogInput_RangeMode
                    section.data(3).logicalSrcIdx = 15;
                    section.data(3).dtTransOffset = 3;

                    ;% template_inverted_pendulum_2021b_P.AnalogOutput_RangeMode
                    section.data(4).logicalSrcIdx = 16;
                    section.data(4).dtTransOffset = 4;

                    ;% template_inverted_pendulum_2021b_P.AnalogInput_VoltRange
                    section.data(5).logicalSrcIdx = 17;
                    section.data(5).dtTransOffset = 5;

                    ;% template_inverted_pendulum_2021b_P.AnalogOutput_VoltRange
                    section.data(6).logicalSrcIdx = 18;
                    section.data(6).dtTransOffset = 6;

            nTotData = nTotData + section.nData;
            paramMap.sections(2) = section;
            clear section

            section.nData     = 9;
            section.data(9)  = dumData; %prealloc

                    ;% template_inverted_pendulum_2021b_P.Setpoint_Value
                    section.data(1).logicalSrcIdx = 19;
                    section.data(1).dtTransOffset = 0;

                    ;% template_inverted_pendulum_2021b_P.Off_Value
                    section.data(2).logicalSrcIdx = 20;
                    section.data(2).dtTransOffset = 2;

                    ;% template_inverted_pendulum_2021b_P.UnitDelay_InitialCondition
                    section.data(3).logicalSrcIdx = 21;
                    section.data(3).dtTransOffset = 3;

                    ;% template_inverted_pendulum_2021b_P.Constant1_Value
                    section.data(4).logicalSrcIdx = 22;
                    section.data(4).dtTransOffset = 4;

                    ;% template_inverted_pendulum_2021b_P.UnitDelay_InitialCondition_p
                    section.data(5).logicalSrcIdx = 23;
                    section.data(5).dtTransOffset = 5;

                    ;% template_inverted_pendulum_2021b_P.uvto5v_UpperSat
                    section.data(6).logicalSrcIdx = 24;
                    section.data(6).dtTransOffset = 6;

                    ;% template_inverted_pendulum_2021b_P.uvto5v_LowerSat
                    section.data(7).logicalSrcIdx = 25;
                    section.data(7).dtTransOffset = 7;

                    ;% template_inverted_pendulum_2021b_P.Gain_Gain
                    section.data(8).logicalSrcIdx = 26;
                    section.data(8).dtTransOffset = 8;

                    ;% template_inverted_pendulum_2021b_P.Gain_Gain_b
                    section.data(9).logicalSrcIdx = 27;
                    section.data(9).dtTransOffset = 9;

            nTotData = nTotData + section.nData;
            paramMap.sections(3) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% template_inverted_pendulum_2021b_P.Switch_CurrentSetting
                    section.data(1).logicalSrcIdx = 28;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(4) = section;
            clear section


            ;%
            ;% Non-auto Data (parameter)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        paramMap.nTotData = nTotData;



    ;%**************************
    ;% Create Block Output Map *
    ;%**************************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 1;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc sigMap
        ;%
        sigMap.nSections           = nTotSects;
        sigMap.sectIdxOffset       = sectIdxOffset;
            sigMap.sections(nTotSects) = dumSection; %prealloc
        sigMap.nTotData            = -1;

        ;%
        ;% Auto data (template_inverted_pendulum_2021b_B)
        ;%
            section.nData     = 7;
            section.data(7)  = dumData; %prealloc

                    ;% template_inverted_pendulum_2021b_B.Convertionactor
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% template_inverted_pendulum_2021b_B.Convertion
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 1;

                    ;% template_inverted_pendulum_2021b_B.Divide1
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 2;

                    ;% template_inverted_pendulum_2021b_B.Switch
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 4;

                    ;% template_inverted_pendulum_2021b_B.RateTransition1
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 5;

                    ;% template_inverted_pendulum_2021b_B.Gain
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 7;

                    ;% template_inverted_pendulum_2021b_B.RateTransition
                    section.data(7).logicalSrcIdx = 6;
                    section.data(7).dtTransOffset = 8;

            nTotData = nTotData + section.nData;
            sigMap.sections(1) = section;
            clear section


            ;%
            ;% Non-auto Data (signal)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        sigMap.nTotData = nTotData;



    ;%*******************
    ;% Create DWork Map *
    ;%*******************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 2;
        sectIdxOffset = 1;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc dworkMap
        ;%
        dworkMap.nSections           = nTotSects;
        dworkMap.sectIdxOffset       = sectIdxOffset;
            dworkMap.sections(nTotSects) = dumSection; %prealloc
        dworkMap.nTotData            = -1;

        ;%
        ;% Auto data (template_inverted_pendulum_2021b_DW)
        ;%
            section.nData     = 4;
            section.data(4)  = dumData; %prealloc

                    ;% template_inverted_pendulum_2021b_DW.UnitDelay_DSTATE
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% template_inverted_pendulum_2021b_DW.UnitDelay_DSTATE_o
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 2;

                    ;% template_inverted_pendulum_2021b_DW.RateTransition1_Buffer
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 4;

                    ;% template_inverted_pendulum_2021b_DW.RateTransition_Buffer
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 6;

            nTotData = nTotData + section.nData;
            dworkMap.sections(1) = section;
            clear section

            section.nData     = 4;
            section.data(4)  = dumData; %prealloc

                    ;% template_inverted_pendulum_2021b_DW.AnalogInput_PWORK
                    section.data(1).logicalSrcIdx = 4;
                    section.data(1).dtTransOffset = 0;

                    ;% template_inverted_pendulum_2021b_DW.AnalogOutput_PWORK
                    section.data(2).logicalSrcIdx = 5;
                    section.data(2).dtTransOffset = 1;

                    ;% template_inverted_pendulum_2021b_DW.Scope_PWORK.LoggedData
                    section.data(3).logicalSrcIdx = 6;
                    section.data(3).dtTransOffset = 2;

                    ;% template_inverted_pendulum_2021b_DW.Scope1_PWORK.LoggedData
                    section.data(4).logicalSrcIdx = 7;
                    section.data(4).dtTransOffset = 3;

            nTotData = nTotData + section.nData;
            dworkMap.sections(2) = section;
            clear section


            ;%
            ;% Non-auto Data (dwork)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        dworkMap.nTotData = nTotData;



    ;%
    ;% Add individual maps to base struct.
    ;%

    targMap.paramMap  = paramMap;
    targMap.signalMap = sigMap;
    targMap.dworkMap  = dworkMap;

    ;%
    ;% Add checksums to base struct.
    ;%


    targMap.checksum0 = 3205839546;
    targMap.checksum1 = 3728708207;
    targMap.checksum2 = 603472540;
    targMap.checksum3 = 1838654031;

