const Lab = require('lab');
const sinon = require('sinon');
const Code = require('code');

const lab = exports.lab = Lab.script();

lab.describe('Testing log helpers', () => {
    lab.test('should call console info method', () => {
        const log = require('../../../utils/helpers/log.helpers');
        const infoStub = sinon.stub(console, 'info');

        log.info('test');

        Code.expect(infoStub.calledOnce).to.be.true();

        infoStub.restore();
    });

    lab.test('should call console error method', () => {
        const log = require('../../../utils/helpers/log.helpers');
        const errorStub = sinon.stub(console, 'error');

        log.error('test');

        Code.expect(errorStub.calledOnce).to.be.true();

        errorStub.restore();
    });

    lab.test('should generate a fixed size string on error', () => {
        const log = require('../../../utils/helpers/log.helpers');
        const errorStub = sinon.stub(console, 'error');

        log.logModule('PluginName', true);

        Code.expect(errorStub.calledOnce).to.be.true();
        Code.expect(errorStub.args).to.be.an.array();
        Code.expect(errorStub.args.length).to.equals(1);
        Code.expect(errorStub.args[0]).to.be.an.array();
        Code.expect(errorStub.args[0].length).to.equals(1);
        Code.expect(errorStub.args[0][0]).to.be.a.string();
        Code.expect(errorStub.args[0][0].length).to.equals(log.MAX_DOTTED_LENGTH + 'ERROR'.length);

        errorStub.restore();
    });

    lab.test('should generate a fixed size string on success', () => {
        const log = require('../../../utils/helpers/log.helpers');
        const infoStub = sinon.stub(console, 'info');

        log.logModule('PluginName');

        Code.expect(infoStub.calledOnce).to.be.true();
        Code.expect(infoStub.args).to.be.an.array();
        Code.expect(infoStub.args.length).to.equals(1);
        Code.expect(infoStub.args[0]).to.be.an.array();
        Code.expect(infoStub.args[0].length).to.equals(1);
        Code.expect(infoStub.args[0][0]).to.be.a.string();
        Code.expect(infoStub.args[0][0].length).to.equals(log.MAX_DOTTED_LENGTH + 'OK'.length);

        infoStub.restore();
    });
});
