import pymysql

con = pymysql.connect(host='localhost',
                      user='root',
                      password='Luna1098?',
                      database='gungeonDB')
"""
cursor = con.cursor()
inst = 'select all aid, aname from Artist'
cursor.execute(inst)
data = cursor.fetchall()

for x in data:
    print(f'{x[0]} {x[1]}')
"""

print("""\
'########:'##::: ##:'########:'########:'########::                                        
 ##.....:: ###:: ##:... ##..:: ##.....:: ##.... ##:                                        
 ##::::::: ####: ##:::: ##:::: ##::::::: ##:::: ##:                                        
 ######::: ## ## ##:::: ##:::: ######::: ########::                                        
 ##...:::: ##. ####:::: ##:::: ##...:::: ##.. ##:::                                        
 ##::::::: ##:. ###:::: ##:::: ##::::::: ##::. ##::                                        
 ########: ##::. ##:::: ##:::: ########: ##:::. ##:                                        
........::..::::..:::::..:::::........::..:::::..::                                        
'########:'##::::'##:'########:                                                            
... ##..:: ##:::: ##: ##.....::                                                            
::: ##:::: ##:::: ##: ##:::::::                                                            
::: ##:::: #########: ######:::                                                            
::: ##:::: ##.... ##: ##...::::                                                            
::: ##:::: ##:::: ##: ##:::::::                                                            
::: ##:::: ##:::: ##: ########:                                                            
:::..:::::..:::::..::........::                                                            
:'######:::'##::::'##:'##::: ##::'######:::'########::'#######::'##::: ##:                 
'##... ##:: ##:::: ##: ###:: ##:'##... ##:: ##.....::'##.... ##: ###:: ##:                 
 ##:::..::: ##:::: ##: ####: ##: ##:::..::: ##::::::: ##:::: ##: ####: ##:                 
 ##::'####: ##:::: ##: ## ## ##: ##::'####: ######::: ##:::: ##: ## ## ##:                 
 ##::: ##:: ##:::: ##: ##. ####: ##::: ##:: ##...:::: ##:::: ##: ##. ####:                 
 ##::: ##:: ##:::: ##: ##:. ###: ##::: ##:: ##::::::: ##:::: ##: ##:. ###:                 
. ######:::. #######:: ##::. ##:. ######::: ########:. #######:: ##::. ##:                 
:......:::::.......:::..::::..:::......::::........:::.......:::..::::..::                 
:'######:::'#######::'##::::'##:'########:::::'###::::'##::: ##:'####::'#######::'##::: ##:
'##... ##:'##.... ##: ###::'###: ##.... ##:::'## ##::: ###:: ##:. ##::'##.... ##: ###:: ##:
 ##:::..:: ##:::: ##: ####'####: ##:::: ##::'##:. ##:: ####: ##:: ##:: ##:::: ##: ####: ##:
 ##::::::: ##:::: ##: ## ### ##: ########::'##:::. ##: ## ## ##:: ##:: ##:::: ##: ## ## ##:
 ##::::::: ##:::: ##: ##. #: ##: ##.....::: #########: ##. ####:: ##:: ##:::: ##: ##. ####:
 ##::: ##: ##:::: ##: ##:.:: ##: ##:::::::: ##.... ##: ##:. ###:: ##:: ##:::: ##: ##:. ###:
. ######::. #######:: ##:::: ##: ##:::::::: ##:::: ##: ##::. ##:'####:. #######:: ##::. ##:
:......::::.......:::..:::::..::..:::::::::..:::::..::..::::..::....:::.......:::..::::..::
""")

#variable initialization
cursor = con.cursor()
instruction = 'nothing for now'
init_choice = int(-1)
net_worth_data = []
w_worth_list = []
i_worth_list = []

while init_choice != 2:
    init_choice = int(input("0 to start a new run, 1 to look at old runs, or 2 to quit: "))
    new_run_choice = 'z'

    #new run
    if init_choice == 0:
        #adding the new run to the Run table
        character = input('What character are you playing?: ')
        instruction = 'insert into Run (runCharacter) values ("' + character + '");'
        cursor.execute(instruction)

        #saving run_num for future use
        instruction = 'select all runNo from Run'
        cursor.execute(instruction)
        data = cursor.fetchall()
        run_num = str(sorted(data)[-1][0])

        #the user can record the weapons and items they find during their run
        while new_run_choice != 'e':
            new_run_choice = input("w to add a weapon, i to add an item, e to end the run: ")

            #adding a new weapon to the run
            if new_run_choice == 'w' or new_run_choice == 'W':
                weapon_name = input('What weapon did you get?: ')
                instruction = 'insert into CurrentlyHasWeapon (weaponName, runNo) values ("' + weapon_name + '", ' + run_num + ');'
                cursor.execute(instruction)

            #adding a new item to the run
            elif new_run_choice == 'i' or new_run_choice == 'I':
                item_name = input('What item did you get?: ')
                instruction = 'insert into CurrentlyHasItem (itemName, runNo) values ("' + item_name + '", ' + run_num + ');'
                cursor.execute(instruction)

            #input handling
            elif new_run_choice != 'w' and new_run_choice != 'W' and new_run_choice != 'i' and new_run_choice != 'I' and new_run_choice != 'e' and new_run_choice != 'E':
                print('Invalid Input')
        
    #old runs
    elif init_choice == 1:
        print()
        old_run_choice = 'z'
        
        #gives the user a choice to see more information about any run
        while old_run_choice != 'b' and old_run_choice != 'B':
            data_list = []
            w_worth_list = []
            i_worth_list = []
            net_worth_data = []
            #getting all old runs
            instruction = 'select all runNo, runCharacter from Run'
            cursor.execute(instruction)
            data = cursor.fetchall()
            #getting net worth info
            for x in range(0, len(data)):
                w_worth_data = ()
                i_worth_data = ()
                instruction = 'select SUM(w.sellPrice) as TotalWeaponValue from Weapons as w, CurrentlyHasWeapon as chw where w.weaponName = chw.weaponName and chw.runNo = ' + str(x + 1) + ';'
                cursor.execute(instruction)
                w_worth_data = cursor.fetchall()
                if w_worth_data[0][0] != None:
                    w_worth_list.append(int(w_worth_data[0][0]))
                else:
                    w_worth_list.append(0)
                instruction = 'select SUM(i.sellPrice) as TotalItemValue from Items as i, CurrentlyHasItem as chi where i.itemName = chi.itemName and chi.runNo = ' + str(x + 1) + ';'
                cursor.execute(instruction)
                i_worth_data = cursor.fetchall()
                if i_worth_data[0][0] != None:
                    i_worth_list.append(int(i_worth_data[0][0]))
                else:
                    i_worth_list.append(0)
            #making a list of total net worth per run
            for x in range(0, len(w_worth_list)):
                net_worth_data.append(int(w_worth_list[x]) + int(i_worth_list[x]))
            #making a list with all run information (+net worth)
            for x in range(0, len(data)):
                data_list.append(list(sorted(data)[x]))
                data_list[x].append(net_worth_data[x])
            #printing all old runs
            print('Run   Character       Net Worth')
            for x in sorted(data_list):
                print(f'{x[0]:<5} {x[1]:<15} {x[2]}')
            print()
            
            old_run_choice = input('Enter a run number to see what weapons and items were used during that run, or enter b to go back: ')

            if old_run_choice != 'b' and old_run_choice != 'B':
                #weapon list
                instruction = 'select weaponName from CurrentlyHasWeapon where runNo = ' + old_run_choice + ';'
                cursor.execute(instruction)
                data = cursor.fetchall()
                print('\n\n\n')
                print('Weapons: ')
                if len(data) > 0:
                    for x in data:
                        print(f'{x[0]}')
                else:
                    print('NONE')
                    

                #item list
                instruction = 'select itemName from CurrentlyHasItem where runNo = ' + old_run_choice + ';'
                cursor.execute(instruction)
                data = cursor.fetchall()
                print('\n\n\n')
                print('Items: ')
                if len(data) > 0:
                    for x in data:
                        print(f'{x[0]}')
                else:
                    print('NONE')

                #synergy list
                #w_w synergies
                instruction = 'select ww.weaponOne as WeaponOne, ww.weaponTwo as WeaponTwo, ww.synergyEffect as CurrentWeaponSynergies from W_W_Synergy as ww where exists\
                               (select * from CurrentlyHasWeapon as chw where chw.runNo = ' + old_run_choice + ' and chw.weaponName = ww.weaponOne) and exists (select * from CurrentlyHasWeapon as chw where\
                               chw.runNo = ' + old_run_choice + ' and chw.weaponName = ww.weaponTwo);'
                cursor.execute(instruction)
                w_w_data = cursor.fetchall()
                #w_i synergies
                instruction = 'select wi.weaponName as WeaponName, wi.itemName as ItemName, wi.synergyEffect as CurrentWeaponItemSynergies from W_I_Synergy as wi where exists\
                               (select * from CurrentlyHasWeapon as chw where chw.runNo = ' + old_run_choice + ' and chw.weaponName = wi.weaponName) and exists (select * from CurrentlyHasItem as chi where\
                               chi.runNo = ' + old_run_choice + ' and chi.itemName = wi.itemName);'
                cursor.execute(instruction)
                w_i_data = cursor.fetchall()
                #i_i synergies
                instruction = 'select ii.itemOne as ItemOne, ii.itemTwo as ItemTwo, ii.synergyEffect as CurrentItemSynergies from I_I_Synergy as ii where exists\
                               (select * from CurrentlyHasItem as chi where chi.runNo = ' + old_run_choice + ' and chi.itemName = ii.itemOne) and exists (select * from CurrentlyHasItem as chi where\
                               chi.runNo = ' + old_run_choice + ' and chi.itemName = ii.itemTwo);'
                cursor.execute(instruction)
                i_i_data = cursor.fetchall()

                print('\n\n\n')
                print('Synergies: ')
                if len(w_w_data) > 0:
                    for x in w_w_data:
                        print(f'{x[0]} and {x[1]} - {x[2]}')
                if len(w_i_data) > 0:
                    for x in w_i_data:
                        print(f'{x[0]} and {x[1]} - {x[2]}')
                if len(i_i_data) > 0:
                    for x in i_i_data:
                        print(f'{x[0]} and {x[1]} - {x[2]}')
                if len(w_w_data) == 0 and len(w_i_data) == 0 and len(i_i_data) == 0:
                    print('NONE')
                print('\n\n\n')

            
    #input handling
    elif init_choice != 0 and init_choice != 1 and init_choice != 2:
        print('Invalid Input')


#these last few lines make the interaction with mySQL a lot smoother
instruction = 'drop database gungeonDB'
cursor.execute(instruction)

#this MUST be the last line
con.close()
