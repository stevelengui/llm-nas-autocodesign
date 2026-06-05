import re

with open('app_aligned.py', 'r') as f:
    content = f.read()

# Correction du calcul thermal
old_calc = r'delta_t_raw = \(power \* THERMAL_RESISTANCE\) \/ 1000'
new_calc = 'delta_t_raw = (power * THERMAL_RESISTANCE) / 100'

content = re.sub(old_calc, new_calc, content)

# Ajuster également la valeur par défaut de THERMAL_RESISTANCE
content = content.replace('THERMAL_RESISTANCE = 25.0', 'THERMAL_RESISTANCE = 40.0')

with open('app_aligned.py', 'w') as f:
    f.write(content)

print("✅ Patch thermal appliqué")
print("   - Résistance thermique: 25 → 40 °C/W")
print("   - Division: /1000 → /100")
