const { runQuery } = require('../../../../../common/snowflake/test-utils');

test('HILBERTQUADKEY_FROMID.test should work', async () => {
    const query = `
        SELECT HILBERTQUADKEY_FROMID(VALUE) as key
        FROM LATERAL FLATTEN(input => ARRAY_CONSTRUCT(
            -8286623314361712640, 5008548143403368448,
            7416309021449125888, -6902629179221606400,
            4985491052606295040, -5790199077674720336
        )) as id
    `;
    const rows = await runQuery(query);
    expect(rows.map(r => r.KEY)).toEqual([
        '4/12', '2/02300033', '3/03131200023201', '5/0001221313222222120',
        '2/0221200002312111222332101', '5/1331022022103232320303230131'
    ]);
});

test('HILBERTQUADKEY_FROMID should fail with NULL argument', async () => {
    const query = 'SELECT HILBERTQUADKEY_FROMID(NULL)';
    await expect(runQuery(query)).rejects.toThrow('NULL argument passed to UDF');
});