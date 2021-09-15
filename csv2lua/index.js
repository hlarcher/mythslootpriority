const csv = require('csv-parser');
const fs = require('fs');
const js2lua = require('js2lua');

let output = '';

const inputClasses = [
    'Warrior - Tank',
    'Warrior - DPS',
    'Druid - Feral',
    'Druid - Balance',
    'Druid - Resto',
    'Hunter',
    'Mage - Frost',
    'Mage - Fire',
    'Mage - Arcane',
    'Warlock',
    'Shaman - Enh',
    'Shaman - Resto',
    'Shaman - Ele',
    'Paladin - Tank',
    'Paladin - Holy',
    'Paladin - Ret',
    'Rogue',
    'Priest - Holy',
    'Priest - Shadow',
];

const outputClasses = [
    'warriorprot',
    'warriordps',
    'druidferal',
    'druidbalance',
    'druidresto',
    'hunter',
    'magefrost',
    'magefire',
    'magearcane',
    'warlock',
    'shamanenh',
    'shamanresto',
    'shamanelem',
    'palaprot',
    'palaholy',
    'palaret',
    'rogue',
    'priestholy',
    'priestshadow',
];

function getPrioForItem(row, prio) {
    const classes = [];

    for (let i = 0; i < inputClasses.length; i++) {
        const clsVal = row[inputClasses[i]];
        if (String(clsVal) === String(prio)) classes.push(outputClasses[i]);
    }

    return classes.join(',');
}

function parseRow(row) {
    const parsedRow = {
        name: row['Item'],
        id: row['URL'].replace('https://tbc.wowhead.com/item=', ''),
        prio1: getPrioForItem(row, 1),
        prio2: getPrioForItem(row, 2),
        prio3: getPrioForItem(row, 3),
        prio4: getPrioForItem(row, 4),
        note: row['Comment'],
    };

    return parsedRow;
}


fs.createReadStream('loot.csv')
    .pipe(csv({ trim: true }))
    .on('data', (row) => {
        output += js2lua.convert(parseRow(row), 1) + ',\n';
    })
    .on('end', () => {
        fs.writeFileSync('loot.lua', output);
        console.log('CSV file successfully processed');
  });