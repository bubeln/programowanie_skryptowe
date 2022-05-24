let y = 0
let x = 0
let mod = 0
for (let indeks = 0; indeks <= 3; indeks++) {
    blocks.fill(
    AIR,
    world(-20 + indeks, 1, -35 + indeks),
    world(20 - indeks, 3, 22 - indeks),
    FillOperation.Outline
    )
}
blocks.fill(
WATER,
world(-20, 2, -35),
world(20, 2, 22),
FillOperation.Replace
)
blocks.fill(
GRASS,
world(-16, 1, -31),
world(16, 3, 18),
FillOperation.Outline
)
blocks.fill(
PLANKS_OAK,
world(3, 3, 25),
world(6, 3, 26),
FillOperation.Replace
)
blocks.fill(
PLANKS_OAK,
world(3, 4, 23),
world(6, 4, 24),
FillOperation.Replace
)
blocks.fill(
PLANKS_OAK,
world(3, 5, 19),
world(6, 5, 22),
FillOperation.Replace
)
blocks.fill(
PLANKS_OAK,
world(3, 4, 17),
world(6, 4, 18),
FillOperation.Replace
)
blocks.fill(
PLANKS_OAK,
world(3, 3, 15),
world(6, 3, 16),
FillOperation.Replace
)
blocks.fill(
COBBLESTONE,
world(-2, 6, -6),
world(-1, 10, -22),
FillOperation.Replace
)
blocks.fill(
DIORITE,
world(-2, 3, -6),
world(-1, 5, -22),
FillOperation.Replace
)
blocks.fill(
ANDESITE,
world(-4, 3, -2),
world(-1, 24, -5),
FillOperation.Outline
)
for (let i = 0; i <= 4; i++) {
    for (let j = 0; j <= 4; j++) {
        mod = (i + j) % 2
        if (mod == 0) {
            x = (i + 1) * -1
            y = (j + 2) * -1
            blocks.place(AIR, world(x, 24, y))
        }
    }
}
blocks.fill(
IRON_BARS,
world(-2, 18, -2),
world(-2, 19, -2),
FillOperation.Replace
)
blocks.fill(
STONE,
world(0, 3, -10),
world(8, 16, 0),
FillOperation.Outline
)
blocks.fill(
IRON_BARS,
world(1, 10, 0),
world(1, 11, 0),
FillOperation.Replace
)
blocks.fill(
IRON_BARS,
world(7, 10, 0),
world(7, 11, 0),
FillOperation.Replace
)
blocks.fill(
IRON_BARS,
world(4, 4, 0),
world(5, 6, 0),
FillOperation.Outline
)
blocks.fill(
BEDROCK,
world(0, 3, -11),
world(8, 14, -25),
FillOperation.Outline
)
blocks.fill(
AIR,
world(2, 4, -10),
world(2, 5, -11),
FillOperation.Outline
)
blocks.fill(
ANDESITE,
world(9, 3, -2),
world(12, 24, -5),
FillOperation.Outline
)
for (let i = 0; i <= 4; i++) {
    for (let j = 0; j <= 4; j++) {
        mod = (i + j) % 2
        if (mod == 0) {
            x = i + 9
            y = (j + 2) * -1
            blocks.place(AIR, world(x, 24, y))
        }
    }
}
blocks.fill(
IRON_BARS,
world(10, 18, -2),
world(10, 19, -2),
FillOperation.Replace
)
blocks.fill(
DIORITE,
world(9, 3, -6),
world(10, 5, -22),
FillOperation.Replace
)
blocks.fill(
COBBLESTONE,
world(9, 6, -6),
world(10, 10, -22),
FillOperation.Replace
)
