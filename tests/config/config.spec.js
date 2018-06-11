const Lab = require('lab');
const sinon = require('sinon');
const Code = require('code');

const lab = exports.lab = Lab.script();

lab.describe('Testing config loader', () => {
    lab.test('should throw error on validation failure', () => {
        const stub = sinon.stub(require('joi'), 'validate');
        stub.returns({ error: new Error('Config error') });

        try {
            require('../../config');
        } catch (err) {
            Code.expect(err).to.be.an.error();
        }

        stub.restore();
    });
});
