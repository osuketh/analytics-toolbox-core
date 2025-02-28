const fs = require('fs');
const path = require('path');

const { BigQuery } = require('@google-cloud/bigquery');

const BQ_PROJECT = process.env.BQ_PROJECT;
const BQ_DATASET_PREFIX = process.env.BQ_DATASET_PREFIX;
const BQ_PREFIX = `${BQ_PROJECT}.${BQ_DATASET_PREFIX}`;
const BQ_DATASET = `${BQ_DATASET_PREFIX}carto`;

const client = new BigQuery({ projectId: `${BQ_PROJECT}` });

async function runQuery (query, options) {
    options = Object.assign({}, { 'timeoutMs' : 60000 }, options);
    query = replaceBQPrefix(query);
    const [rows] = await client.query(query, options);
    return rows;
}

function replaceBQPrefix(text) {
    return text.replace(/@@BQ_PREFIX@@/g, BQ_PREFIX)
        .replace(/@@BQ_PROJECT@@/g, BQ_PROJECT)
        .replace(/@@BQ_DATASET_PREFIX@@/g, BQ_DATASET_PREFIX);
}

async function loadTable (tablename, filepath, columns, viewName) {
    const metadata = {
        sourceFormat: 'CSV',
        skipLeadingRows: 1,
        schema: { fields: columns },
        writeDisposition: 'WRITE_TRUNCATE'
    };

    await client.dataset(BQ_DATASET).table(tablename).load(filepath, metadata);
    if (viewName) {
        await createView(viewName, `SELECT * FROM \`${BQ_DATASET}.${tablename}\``);
    }
}

async function createView (viewName, query) {
    const options = {
        view: query
    };
    await client.dataset(BQ_DATASET).createTable(viewName, options);
}

async function deleteTable (tablename) {
    const table = client.dataset(BQ_DATASET).table(tablename);
    const exists = await table.exists();
    if (exists[0]) {
        await table.delete();
    }
}

function readJSONFixture (name) {
    const filepath = path.join('.', 'test', 'integration', 'fixtures', `${name}.json`);
    return JSON.parse(fs.readFileSync(filepath));
}

function writeJSONFixture (name, json) {
    const filepath = path.join('.', 'test', 'integration', 'fixtures', `${name}.json`);
    const data = JSON.stringify(json);
    fs.writeFileSync(filepath, data);
}

async function cancelJob (jobId) {
    const job = bigquery.job(jobId);
    // Attempt to cancel job
    const [apiResult] = await job.cancel();
    return apiResult;
}

function sortByKey (list, key) {
    return list.sort((a, b) => (a[key] > b[key]) ? 1 : -1);
}

function sortByKeyAndRound (list, orderKey, roundedKeys, precision=10) {
    list = list.sort((a, b) => (a[orderKey] > b[orderKey]) ? 1 : -1);
    for (let row of list) {
        for (let roundKey of roundedKeys) {
            if (row[roundKey]) {
                row[roundKey] = row[roundKey].toPrecision(precision);
            }
        }
    }
    return list;
}

module.exports = {
    runQuery,
    loadTable,
    createView,
    deleteTable,
    readJSONFixture,
    writeJSONFixture,
    cancelJob,
    sortByKey,
    sortByKeyAndRound
};