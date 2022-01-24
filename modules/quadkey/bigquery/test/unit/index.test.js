const quadkeyLib = require('../../dist/index');
const version = require('../../package.json').version;

test('quadkey library defined', () => {
    expect(quadkeyLib.bbox).toBeDefined();
    expect(quadkeyLib.kRing).toBeDefined();
    expect(quadkeyLib.kRingDistances).toBeDefined();
    expect(quadkeyLib.sibling).toBeDefined();
    expect(quadkeyLib.toChildren).toBeDefined();
    expect(quadkeyLib.quadkeyFromQuadint).toBeDefined();
    expect(quadkeyLib.quadintFromQuadkey).toBeDefined();
    expect(quadkeyLib.quadintFromLocation).toBeDefined();
    expect(quadkeyLib.quadintToGeoJSON).toBeDefined();
    expect(quadkeyLib.geojsonToQuadints).toBeDefined();
    expect(quadkeyLib.ZXYFromQuadint).toBeDefined();
    expect(quadkeyLib.getQuadintResolution).toBeDefined();
    expect(quadkeyLib.version).toBe(version);
});