import sys

# Initialize empty sets and counters
true_assignments = set()
false_assignments = set()
num_propositions = num_splits = 0


def print_cnf(cnf):

    s = '(' + ')('.join(cnf).replace(' ', '+') + ')' if cnf else '()'
    print(f"CNF = {s}")


def solve(cnf, literals, modified_cnf=None, modified_literals=None):

    if modified_cnf is None:
        modified_cnf = cnf[:]  # Create a different copy of the CNF formula
    if modified_literals is None:
        modified_literals = literals[:]  # Create a different copy of the literals list

    print_cnf(modified_cnf)  # Print the CNF formula
    new_true = []
    new_false = []
    global true_assignments, false_assignments, num_propositions, num_splits
    true_assignments = set(true_assignments)
    false_assignments = set(false_assignments)
    num_splits += 1
    modified_cnf = list(set(modified_cnf))
    units = [clause for clause in modified_cnf if len(clause) < 3]
    units = list(set(units))
    if len(units):
        for unit in units:
            num_propositions += 1
            if '!' in unit:
                false_assignments.add(unit[-1])
                new_false.append(unit[-1])
                i = 0
                while True:
                    if unit in modified_cnf[i]:
                        modified_cnf.remove(modified_cnf[i])
                        i -= 1
                    elif unit[-1] in modified_cnf[i]:
                        modified_cnf[i] = modified_cnf[i].replace(unit[-1], '').strip()
                    i += 1
                    if i >= len(modified_cnf):
                        break
                # Remove clauses containing the negation of the assigned variable
                modified_cnf = [clause for clause in modified_cnf if unit[-1] not in clause]
            else:
                true_assignments.add(unit)
                new_true.append(unit)
                i = 0
                while True:
                    if '!' + unit in modified_cnf[i]:
                        modified_cnf[i] = modified_cnf[i].replace('!' + unit, '').strip()
                        if '  ' in modified_cnf[i]:
                            modified_cnf[i] = modified_cnf[i].replace('  ', ' ')
                    elif unit in modified_cnf[i]:
                        modified_cnf.remove(modified_cnf[i])
                        i -= 1
                    i += 1
                    if i >= len(modified_cnf):
                        break
    print('Units =', units)
    print('CNF after unit propagation = ', end='')
    print_cnf(modified_cnf)  # Print the CNF formula after unit propagation

    if len(modified_cnf) == 0:
        return True

    if sum(len(clause) == 0 for clause in modified_cnf):
        for literal in new_true:
            true_assignments.remove(literal)
        for literal in new_false:
            false_assignments.remove(literal)
        print('Null clause found, backtracking...')
        return False
    modified_literals = [k for k in list(set(''.join(modified_cnf))) if k.isalpha()]
    print('modified literals', modified_literals)

    x = modified_literals[0]
    if solve(cnf, literals, modified_cnf + [x], modified_literals):
        return True
    elif solve(cnf, literals, modified_cnf + ['!' + x], modified_literals):
        return True
    else:
        for literal in new_true:
            true_assignments.remove(literal)
        for literal in new_false:
            false_assignments.remove(literal)
        return False

def dpll():
    """
    Main function to read the CNF formula from the input file and invoke the DPLL solver.
    """
    global true_assignments, false_assignments, num_propositions, num_splits
    input_cnf = open(sys.argv[1], 'r').read()  # Read the input CNF formula from the file
    literals = [char for char in input_cnf if char.isalpha()]  # Extract literals from the input CNF formula
    cnf = input_cnf.splitlines()  # Split the input CNF formula into clauses
    print("CNF before solving:")

    # Invoke the DPLL solver to solve the CNF formula
    if solve(cnf, literals):
        print(f'\nSplits = {num_splits}')
        print(f'Unit Propagations = {num_propositions}')
        print('Result: SAT')
        print('Decisions:')
        for literal in true_assignments:
            print(f'\t{literal} = True')
        for literal in false_assignments:
            print(f'\t{literal} = False')
    else:
        print('\nReached first node')
        print(f'Splits = {num_splits}')
        print(f'Unit Propagations = {num_propositions}')
        print('Result: UNSAT')


if __name__ == '__main__':
    dpll()

