const Lab = require('lab');
const sinon = require('sinon');
const Code = require('code');
const mockery = require('mockery');

const lab = exports.lab = Lab.script();

const PLUGIN_NAME = 'plugin-directory';

lab.describe('Testing plugin helpers methods', () => {
    lab.beforeEach(() => {
        mockery.enable({ useCleanCache: true });
        mockery.warnOnUnregistered(false);
        // mockery.registerSubstitute('../../plugins/health-checks', '../../tests/mocks/plugin.mocks');
        mockery.registerSubstitute(`../../plugins/${PLUGIN_NAME}`, '../../tests/mocks/plugin.mocks');
    });

    lab.afterEach(() => {
        mockery.disable();
        // mockery.deregisterSubstitute('../../plugins/health-checks');
        mockery.deregisterSubstitute(`../../plugins/${PLUGIN_NAME}`);
    });
    lab.test('should log and throw error if register method fails', async() => {
        const logModuleStub = sinon.stub(require('../../../utils/helpers/log.helpers'), 'logModule');
        const serverMock = { register: sinon.stub().throws() };

        const { registerPlugin } = require('../../../utils/helpers/plugins.helpers');
        try {
            await registerPlugin(serverMock, PLUGIN_NAME);
        } catch (err) {}

        Code.expect(serverMock.register.calledOnce).to.be.true();
        Code.expect(logModuleStub.calledOnce).to.be.true();
        Code.expect(logModuleStub.args).to.be.an.array();
        Code.expect(logModuleStub.args.length).to.equals(1);
        Code.expect(logModuleStub.args[0]).to.be.an.array();
        Code.expect(logModuleStub.args[0].length).to.equals(2);
        Code.expect(logModuleStub.args[0][1]).to.be.true();

        logModuleStub.restore();
    });

    lab.test('should log success if register method succeed', async () => {
        const logModuleStub = sinon.stub(require('../../../utils/helpers/log.helpers'), 'logModule');
        const serverMock = { register: sinon.stub() };

        const { registerPlugin } = require('../../../utils/helpers/plugins.helpers');
        try {
            await registerPlugin(serverMock, PLUGIN_NAME);
        } catch (err) {}

        Code.expect(serverMock.register.calledOnce).to.be.true();
        Code.expect(logModuleStub.calledOnce).to.be.true();
        Code.expect(logModuleStub.args).to.be.an.array();
        Code.expect(logModuleStub.args.length).to.equals(1);
        Code.expect(logModuleStub.args[0]).to.be.an.array();
        Code.expect(logModuleStub.args[0].length).to.equals(1);

        logModuleStub.restore();
    });
});
