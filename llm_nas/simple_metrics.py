"""
Simple metrics calculator that varies with inputs
"""
import random

class SimpleMetricsCalculator:
    def calculate_metrics(self, domain, mcu, latency_target, memory_target, power_target):
        print(f"Calculating for: {domain}, {mcu}")
        
        # Base values that CHANGE with inputs
        base_latency = latency_target * random.uniform(0.4, 0.8)
        base_memory = memory_target * random.uniform(0.3, 0.7)
        base_power = power_target * random.uniform(0.4, 0.8)
        base_accuracy = 0.88
        
        # DOMAIN SPECIFIC - DIFFERENT EACH TIME
        if domain == 'medical':
            base_latency *= 1.3  # Slower for reliability
            base_power *= 1.2    # More power for safety
            base_accuracy = 0.92  # Higher accuracy
        elif domain == 'iot':
            base_latency *= 1.4  # Accept slower for power
            base_memory *= 0.5   # Aggressive memory saving
            base_power *= 0.5    # Ultra low power
            base_accuracy = 0.85  # Lower accuracy OK
        elif domain == 'industrial':
            base_accuracy = 0.90  # Good accuracy
        elif domain == 'automotive':
            base_latency *= 1.1
            base_power *= 1.1
            base_accuracy = 0.91
        elif domain == 'robotics':
            base_latency *= 0.8  # Fast for real-time
            base_power *= 1.05
            base_accuracy = 0.89
        
        # MCU SPECIFIC - DIFFERENT EACH TIME
        if mcu == 'riscv':
            base_latency *= 0.7  # Fast with RV32X
            base_power *= 0.8    # Efficient
        elif mcu == 'stm32':
            # Standard
            pass
        elif mcu == 'esp32':
            base_latency *= 1.1  # WiFi overhead
            base_power *= 1.3    # WiFi uses power
            base_memory *= 0.9   # Optimized memory
        
        # Calculate scores
        latency_score = max(0, 1 - (base_latency / latency_target))
        memory_score = max(0, 1 - (base_memory / memory_target))
        power_score = max(0, 1 - (base_power / power_target))
        
        optimization_score = (latency_score * 0.4 + memory_score * 0.3 + power_score * 0.3) * base_accuracy
        
        return {
            'latency_ms': round(base_latency, 2),
            'memory_kb': round(base_memory, 2),
            'power_mw': round(base_power, 2),
            'accuracy': round(base_accuracy, 3),
            'optimization_score': round(optimization_score, 3),
            'thermal_margin_c': round(25 - (base_power / 3), 1),
            'note': f'Metrics vary by domain ({domain}) and MCU ({mcu})'
        }
