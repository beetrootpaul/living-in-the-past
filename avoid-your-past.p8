pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
-- avoid your past
-- by beetroot paul

#include src/utils.lua
#include src/collisions.lua

#include src/game_states/game_state_gameplay.lua
#include src/game_states/game_state_over.lua
#include src/game_states/game_state_splash.lua
#include src/game_states/game_state_start.lua

#include src/animated_sprite.lua
#include src/item.lua
#include src/level.lua
#include src/memory.lua
#include src/memory_chain.lua
#include src/player.lua
#include src/topbar.lua
#include src/trail_particle.lua

#include src/main.lua

--[[

glyphs:
q > […]
w > [∧]
e > [░]
r > [➡️]
t > [⧗]
y > [▤]
u > [⬆️]
i > [☉]
o > [🅾️]
p > [◆]
a > [█]
s > [★]
d > [⬇️]
f > [✽]
g > [●]
h > [♥]
j > [웃]
k > [⌂]
l > [⬅️]
z > [▥]
x > [❎]
c > [🐱]
v > [ˇ]
b > [▒]
n > [♪]
m > [😐]

--]]

__gfx__
00000000111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11999411119994111199941111999411119994111199941111999411119994111199941111999411119994111199941111999411117774111199741111999411
199a9941199a9941199a9941199a9941199a9941199a9941199a9941199a9941199a9941199a9941199a9941199a9941179a994117777741199a9741199a9941
19aaa94119aaa94119aaa94119aaa94119aaa94119aaa94119aaa94119aaa94119aaa94119aaa94119aaa94119aaa94117aaa9411777774119aaa74119aaa941
1999a9411999a9411999a9411999a9411999a9411999a9411999a9411999a9411999a9411999a9411999a9411999a9411799a941177777411999a7411999a941
199a9941199a9941199a9941199a9941199a9941199a9941199a9941199a9941199a9941199a9941199a9941199a9941179a994117777741199a9741199a9941
11999411119994111199941111999411119994111199941111999411119994111199941111999411119994111199941111799411117774111199941111999411
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111d9111000000001153351111533611115335111163351100000000177b7711113bb611113b311116bb31110000000000000000000000000000000000000000
11d99d11000000001775577113336771133b3b311776333100000000670b076113bb677113bbb311776bb3110000000000000000000000000000000000000000
1199991100000000670660765b3b607553b3b33557063b3500000000b66b66b13bbb60713bbbbb31706bbb310000000000000000000000000000000000000000
1d9999d100000000366b366333b3b653333b3b333563b3b300000000bbbbbbb1bbbbbbb1bbbbbbb1bbbbbbb10000000000000000000000000000000000000000
19a999d10000000033b3b3333b3b36533663b663356b3b33000000003bbbbb313bbb6071b66b66b1706bbb310000000000000000000000000000000000000000
199999d100000000533b3b3553b36075670660765706b3b50000000013bbb31113bb6771670b0761776bb3110000000000000000000000000000000000000000
1d999dd10000000013b3b35113336771177557711776333100000000113b3111113bb611177b771116bb31110000000000000000000000000000000000000000
11dddd11000000001153351111533611115335111163351100000000111111111111111111111111111111110000000000000000000000000000000000000000
111de1110000000011deed1111dee21111deed11112eed1100000000188e8811112ee411112e211114ee21110000000000000000000000000000000000000000
11deed1100000000180dd0811eee28811eefefe11882eee100000000480e084112ee488112eee211884ee2110000000000000000000000000000000000000000
11efee110000000028822882dfef280ddefefeedd082efed00000000e44e44e12eee40812eeeee21804eee210000000000000000000000000000000000000000
1deeeed100000000e22fe22eeefef2deeeefefeeed2efefe00000000eeeeeee1eeeeeee1eeeeeee1eeeeeee10000000000000000000000000000000000000000
1efeeed100000000eefefeeeefefe2dee22ef22eed2fefee000000002eeeee212eee4081e44e44e1804eee210000000000000000000000000000000000000000
1efeeed100000000deefefeddefe280d28822882d082fefd0000000012eee21112ee4881480e0841884ee2110000000000000000000000000000000000000000
1deeedd1000000001efefed11eee2881180dd0811882eee100000000112e2111112ee411188e881114ee21110000000000000000000000000000000000000000
11dddd110000000011deed1111dee21111deed11112eed1100000000111111111111111111111111111111110000000000000000000000000000000000000000
__map__
0001010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001101c1d1e1f01320101013701010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010101010101350133013a0138010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001012001010101340101013901010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001010101012201010127010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001013001250123012a01280101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001010101012401010129010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
01070000245403054030530305203051035300353002b0002b0002b0002b0002b0002b0002c0002c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000100
110600002e0542705024050220501f0501f0401f0301b0001100013000180001b0000f0000f000130001100011000110001300013000120000000000000000000000000000000000000000000000000000000000
090600001b0541b0501d0501f05024040270302700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01100000207501c750197400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000010b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000c0430000000000000000c0430000000000000000c0430000000000000000c0430000000000000000c0430000000000000000c0430000000000000000c0430000000000000000c043000000000000000
011000001b54000000000001554000000155400f54000000000000f540000000f5401254000000145400000015540000001554000000155401254000000000001554014540000001254000000145400000000000
011000000f5400000000000000000f5400000014540000000000015540000001554014540000001254000000155400000015540000001554000000145400000015540145400000012540000000f5400000000000
0110000012540000001254000000000000000014540000001554000000000001554000000000001454000000155400000000000000000f5400000012540000001554014540000001254000000195400000000000
011000001b5400000000000000001b5400000015540000001254000000000001254000000145400000000000155400000000000000000f54000000125400000015540145400000012540000000f5400000000000
011000000000000000246150000000000000002461524615000000000024615000000000000000246150000000000000002461524615000000000024615000000000000000246150000000000000002461500000
191000002461500000246150000024615000002461500000000000000024615000002461500000246150000024615000002461500000000000000024615000002461500000246150000024615000002461500000
__music__
02 14424344
01 1416191a
00 1417191a
00 1415191a
02 1418191a

