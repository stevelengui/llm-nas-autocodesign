class OptimizationObjective:
    LATENCY = "latency"
    MEMORY = "memory"
    POWER = "power"
    ACCURACY = "accuracy"

class ParetoFrontierExplorer:
    def __init__(self):
        self.name = "Design Explorer"
