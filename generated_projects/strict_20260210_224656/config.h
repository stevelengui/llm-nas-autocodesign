// Configuration for strict_20260210_224656
#pragma once

// Project identification
#define PROJECT_ID "strict_20260210_224656"
#define PROJECT_DOMAIN_MEDICAL
#define GENERATED_TIMESTAMP "2026-02-10T22:46:56.947067"

// Hardware configuration
#define TARGET_MCU_STM32

#define SYSTEM_CLOCK_MHZ 80

// Performance constraints
#define MAX_LATENCY_MS 15
#define AVAILABLE_MEMORY_KB 128
#define POWER_BUDGET_MW 40

// Model configuration
#define QSNN_HYBRID_MODEL 1
#define MODEL_PARAMETERS 373128
#define MODEL_MEMORY_BYTES 8736
#define QUANTIZATION_BITS 8

// Strict compliance features
#define HW_SW_CODESIGN_EXPLORATION 1
#define EXPLAINABLE_MODEL_INTEGRATION 1
#define META_LEARNING_ROBUSTNESS 1

// Optimizations
#define THERMAL_AWARE_DESIGN 1
#define MEMORY_HIERARCHY_OPTIMIZATION 1
#define DOMAIN_GENERALIZATION 1
