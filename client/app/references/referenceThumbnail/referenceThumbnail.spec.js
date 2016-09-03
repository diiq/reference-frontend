import ReferenceThumbnailModule from './referenceThumbnail'
import ReferenceThumbnailController from './referenceThumbnail.controller';
import ReferenceThumbnailComponent from './referenceThumbnail.component';
import ReferenceThumbnailTemplate from './referenceThumbnail.html';

describe('ReferenceThumbnail', () => {
  let $rootScope, makeController;

  beforeEach(window.module(ReferenceThumbnailModule));
  beforeEach(inject((_$rootScope_) => {
    $rootScope = _$rootScope_;
    makeController = () => {
      return new ReferenceThumbnailController();
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
      expect(ReferenceThumbnailTemplate).to.match(/{{\s?\$ctrl\.name\s?}}/g);
    });
  });

  describe('Component', () => {
      // component/directive specs
      let component = ReferenceThumbnailComponent;

      it('includes the intended template',() => {
        expect(component.template).to.equal(ReferenceThumbnailTemplate);
      });

      it('invokes the right controller', () => {
        expect(component.controller).to.equal(ReferenceThumbnailController);
      });
  });
});