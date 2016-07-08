/* globals
  describe,
  it,
  expect,
  $,
  beforeEach,
  setFixtures,
  spyOn,
  GOVUK,
  jasmine
*/

describe('Webchat', function () {
  // Stub analytics.
  GOVUK.analytics = { trackEvent: function () {} };

  var INSERTION_HOOK = '<div class="js-webchat">' +
    '<div class="js-webchat-advisers-unavailable hidden">Unavailable</div>' +
    '<div class="js-webchat-advisers-busy hidden">Busy</div>' +
    '<div class="js-webchat-advisers-available">' +
      'Available, <div class="js-webchat-open-button">chat now</div>' +
    '</div>' +
  '</div>';
  var $webchat, $advisersUnavailable, $advisersBusy, $advisersAvailable;

  var CHILD_BENEFIT_API_URL = 'https://online.hmrc.gov.uk/webchatprod/egain/chat/entrypoint/checkEligibility/' + 1027;

  var xmlResponse = function (responseType) {
    return $.parseXML('<checkEligibility ' +
      'xmlns:ns5="http://jabber.org/protocol/httpbind" ' +
      'xmlns:ns2="http://bindings.egain.com/chat" ' +
      'xmlns:ns4="urn:ietf:params:xml:ns:xmpp-stanzas" ' +
      'xmlns:ns3="jabber:client" ' +
      'responseType="' + responseType +
    '" />');
  };
  var xmlResponseAvailable = xmlResponse(0);
  var xmlResponseUnavailable = xmlResponse(1);
  var xmlResponseBusy = xmlResponse(2);

  beforeEach(function () {
    setFixtures(INSERTION_HOOK);
    $webchat = $('.js-webchat');
    $advisersUnavailable = $webchat.find('.js-webchat-advisers-unavailable');
    $advisersBusy = $webchat.find('.js-webchat-advisers-busy');
    $advisersAvailable = $webchat.find('.js-webchat-advisers-available');
  });

  describe('on valid application locations', function () {
    function mount () {
      $webchat.map(function () {
        return new GOVUK.Webchat({
          $el: $(this),
          location: '/government/organisations/hm-revenue-customs/contact/child-benefit'
        });
      });
    }

    it('should poll for availability', function () {
      spyOn($, 'ajax');
      mount();
      expect($.ajax).toHaveBeenCalledWith({
        url: CHILD_BENEFIT_API_URL,
        type: 'GET',
        success: jasmine.any(Function),
        error: jasmine.any(Function)
      });
    });

    it('should inform user whether advisors are available', function () {
      spyOn($, 'ajax').and.callFake(function (options) {
        options.success(xmlResponseAvailable);
      });
      mount();
      expect($advisersAvailable.hasClass('hidden')).toBe(false);
      expect($advisersUnavailable.hasClass('hidden')).toBe(true);
      expect($advisersBusy.hasClass('hidden')).toBe(true);
    });

    it('should inform user whether advisors are unavailable', function () {
      spyOn($, 'ajax').and.callFake(function (options) {
        options.success(xmlResponseUnavailable);
      });
      mount();
      expect($advisersAvailable.hasClass('hidden')).toBe(true);
      expect($advisersUnavailable.hasClass('hidden')).toBe(false);
      expect($advisersBusy.hasClass('hidden')).toBe(true);
    });

    it('should inform user whether advisors are busy', function () {
      spyOn($, 'ajax').and.callFake(function (options) {
        options.success(xmlResponseBusy);
      });
      mount();
      expect($advisersAvailable.hasClass('hidden')).toBe(true);
      expect($advisersUnavailable.hasClass('hidden')).toBe(true);
      expect($advisersBusy.hasClass('hidden')).toBe(false);
    });
  });

  describe('on invalid locations', function () {
    function mount () {
      $webchat.map(function () {
        return new GOVUK.Webchat({
          $el: $(this),
          location: '/'
        });
      });
    }

    it('should not poll', function () {
      spyOn($, 'ajax');
      mount();
      expect($.ajax).not.toHaveBeenCalled();
    });
  });
});
