import ReferenceViewModule from './referenceView'
import ReferenceViewController from './referenceView.controller';
import ReferenceViewComponent from './referenceView.component';
import ReferenceViewTemplate from './referenceView.html';

describe('ReferenceView', () => {
  let $rootScope, makeController;

  beforeEach(window.module(ReferenceViewModule));
  beforeEach(inject((_$rootScope_) => {
    $rootScope = _$rootScope_;
    makeController = () => {
      return new ReferenceViewController();
    };
  }));

  describe('Module', () => {
    // top-level specs: i.e., routes, injection, naming
  });

  describe('Controller', () => {
    // controller specs
    it('has a name property [REMOVE]', () => { // erase if removing this.name from the controller
      let controller = makeController();
      expect(controller).to.have.property('name');
    });
  });

  describe('Template', () => {
    // template specs
    // tip: use regex to ensure correct bindings are used e.g., {{  }}
    it('has name in template [REMOVE]', () => {
      expect(ReferenceViewTemplate).to.match(/{{\s?\$ctrl\.name\s?}}/g);
    });
  });

  describe('Component', () => {
      // component/directive specs
      let component = ReferenceViewComponent;

      it('includes the intended template',() => {
        expect(component.template).to.equal(ReferenceViewTemplate);
      });

      it('invokes the right controller', () => {
        expect(component.controller).to.equal(ReferenceViewController);
      });
  });
});
