const { runQuery } = require('../../../../../common/snowflake/test-utils');

test('Works as expected', async () => {
    const query = `
        WITH ids AS
        (
            -- Invalid parameters
            SELECT 1 AS id, NULL as hid UNION ALL
            SELECT 2 AS id, 'ff283473fffffff' as hid UNION ALL
        
            -- Valid parameters
                            -- Hex
            SELECT 3 AS id, '8928308280fffff' as hid UNION ALL
                            -- Pentagon
            SELECT 4 AS id, '821c07fffffffff' as hid
        )
        SELECT
            id,
            H3_ISPENTAGON(hid) as pent
        FROM ids
        ORDER BY id ASC
    `;

    const rows = await runQuery(query);
    expect(rows.length).toEqual(4);
    expect(rows[0].PENT).toEqual(false);
    expect(rows[1].PENT).toEqual(false);
    expect(rows[2].PENT).toEqual(false);
    expect(rows[3].PENT).toEqual(true);
});