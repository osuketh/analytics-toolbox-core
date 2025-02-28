const { runQuery } = require('../../../../../common/bigquery/test-utils');

test('QUADINT_KRING should work', async () => {
    const query = `
        WITH kring_data AS
        ( SELECT row,
            \`@@BQ_PREFIX@@carto.QUADINT_KRING\`(origin, size) as kring_elem,
        FROM UNNEST([
            STRUCT(0 as row, 0 as origin, 1 as size),
            STRUCT(1 as row, 162 as origin, 1 as size),
            STRUCT(2, 12070922, 1),
            STRUCT(3, 791040491538, 1),
            STRUCT(4, 12960460429066265, 1),
            STRUCT(5, 12070922, 2),
            STRUCT(6, 791040491538, 3)
        ]))
        -- cast index to String to avoid INT64 issues in JS
        SELECT ARRAY_AGG(CAST(ke as STRING) order by ke) as kring
        FROM kring_data, UNNEST(kring_elem) as ke
        GROUP BY row
        ORDER BY row
    `;
    const rows = await runQuery(query);
    expect(rows.map(r => r.kring.sort())).toEqual([
        ['0'],
        ['130', '162', '194', '2', '258', '290', '322', '34', '66'],
        ['12038122', '12038154', '12038186', '12070890', '12070922', '12070954', '12103658', '12103690', '12103722'],
        ['791032102898', '791032102930', '791032102962', '791040491506', '791040491538', '791040491570', '791048880114', '791048880146', '791048880178'],
        ['12960459355324409', '12960459355324441', '12960459355324473', '12960460429066233', '12960460429066265', '12960460429066297', '12960461502808057', '12960461502808089', '12960461502808121'],
        ['12005322', '12005354', '12005386', '12005418', '12005450', '12038090', '12038122', '12038154', '12038186', '12038218', '12070858', '12070890', '12070922', '12070954', '12070986', '12103626', '12103658', '12103690', '12103722', '12103754', '12136394', '12136426', '12136458', '12136490', '12136522'],
        ['791015325618', '791015325650', '791015325682', '791015325714', '791015325746', '791015325778', '791015325810', '791023714226', '791023714258', '791023714290', '791023714322', '791023714354', '791023714386', '791023714418', '791032102834', '791032102866', '791032102898', '791032102930', '791032102962', '791032102994', '791032103026', '791040491442', '791040491474', '791040491506', '791040491538', '791040491570', '791040491602', '791040491634', '791048880050', '791048880082', '791048880114', '791048880146', '791048880178', '791048880210', '791048880242', '791057268658', '791057268690', '791057268722', '791057268754', '791057268786', '791057268818', '791057268850', '791065657266', '791065657298', '791065657330', '791065657362', '791065657394', '791065657426', '791065657458']
    ]);
});

test('QUADINT_KRING should fail if any invalid argument', async () => {
    let query = 'SELECT `@@BQ_PREFIX@@carto.QUADINT_KRING`(NULL, 1);';
    await expect(runQuery(query)).rejects.toThrow(/Invalid input origin/);

    query = 'SELECT `@@BQ_PREFIX@@carto.QUADINT_KRING`(-1, 1);';
    await expect(runQuery(query)).rejects.toThrow(/Invalid input origin/);

    query = 'SELECT `@@BQ_PREFIX@@carto.QUADINT_KRING`(162, NULL);';
    await expect(runQuery(query)).rejects.toThrow(/Invalid input size/);

    query = 'SELECT `@@BQ_PREFIX@@carto.QUADINT_KRING`(162, -1);';
    await expect(runQuery(query)).rejects.toThrow(/Invalid input size/);
});