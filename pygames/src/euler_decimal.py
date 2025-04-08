from decimal import Decimal, getcontext


class EulerDecimal:
    MAX_CYCLE_LENGTH_TO_CHECK = 10000
    MAX_COMPARISON_COUNT = 3
    getcontext().prec = MAX_CYCLE_LENGTH_TO_CHECK * (MAX_COMPARISON_COUNT + 1)

    @classmethod
    def from_fraction(cls, numerator, denominator):
        return cls(Decimal(numerator) / Decimal(denominator))

    def __init__(self, decimal):
        self.decimal = decimal
        self.decimal_string = str(decimal)
        self.reversed_decimal_string = self.decimal_string[::-1]
        self.recurring_cycle_length = 0

    def is_repeating(self):
        if len(self.decimal_string) > 10:
            reversed = self.decimal_string[::-1]
            self.cycle_string = reversed.partition(".")[0][1:]
            return True
        return False

    def discover_recurring_cycle(self):
        if not self.is_repeating():
            return

        for i in range(1, self.MAX_CYCLE_LENGTH_TO_CHECK):
            if self._is_recurring_cycle_of_length(i):
                self.recurring_cycle_length = i
                return

    def _is_recurring_cycle_of_length(self, cycle_length):
        cycle = self.cycle_string[0 : cycle_length * self.MAX_COMPARISON_COUNT]
        return cycle.count(cycle[0:cycle_length]) == self.MAX_COMPARISON_COUNT
