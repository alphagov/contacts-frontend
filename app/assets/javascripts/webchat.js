(function (global) {
  'use strict';
  var $ = global.jQuery;
  var windowLocationPathname = global.location.pathname;
  var windowOpen = global.open;
  if (typeof global.GOVUK === 'undefined') { global.GOVUK = {}; }
  var GOVUK = global.GOVUK;

  // Each page will have a different entryPointID, which is a queue id.
  // Don't enable this plugin on pages that don't exist in this map, and
  // uncomment the additional routes as we obtain them.
  // Whether the actual template is displayed is in `contact_presenter#show_webchat?`.
  var entryPointIDs = {};
  entryPointIDs['/government/organisations/hm-revenue-customs/contact/child-benefit'] = 1027;
  entryPointIDs['/government/organisations/hm-revenue-customs/contact/vat-online-services-helpdesk'] = 1028;
  // entryPointIDs['/government/organisations/hm-revenue-customs/contact/national-insurance-numbers'] =;
  // entryPointIDs['/government/organisations/hm-revenue-customs/contact/self-assessment-online-services-helpdesk'] =;
  // entryPointIDs['/government/organisations/hm-revenue-customs/contact/self-assessment'] =;
  // entryPointIDs['/government/organisations/hm-revenue-customs/contact/tax-credits-enquiries'] = 1012;
  // entryPointIDs['/government/organisations/hm-revenue-customs/contact/vat-enquiries'] =;

  var API_URL = 'https://online.hmrc.gov.uk/webchatprod/egain/chat/entrypoint/checkEligibility/';
  var OPEN_CHAT_URL = function (entryPointID) {
    return 'https://online.hmrc.gov.uk/webchatprod/templates/chat/hmrc6/chat.html?entryPointId=' + entryPointID + '&templateName=hmrc6&languageCode=en&countryCode=US&ver=v11';
  };
  var CODE_AGENTS_AVAILABLE = 0;
  var CODE_AGENTS_UNAVAILABLE = 1;
  var CODE_AGENTS_BUSY = 2;
  var POLL_INTERVAL = 15 * 1000;

  function Webchat (options) {
    var $el = $(options.$el);
    var $advisersUnavailable = $el.find('.js-webchat-advisers-unavailable');
    var $advisersBusy = $el.find('.js-webchat-advisers-busy');
    var $advisersAvailable = $el.find('.js-webchat-advisers-available');
    var $openButton = $el.find('.js-webchat-open-button');

    var entryPointID = entryPointIDs[windowLocationPathname];
    var pollingEnabled = true;

    if (entryPointID) {
      pollAvailability();

      $openButton.on('click', handleOpenChat);
    }

    function pollAvailability () {
      checkAvailability();

      setTimeout(function () {
        if (pollingEnabled) {
          pollAvailability();
        }
      }, POLL_INTERVAL);
    }

    function checkAvailability () {
      $.ajax({
        url: API_URL + entryPointID,
        type: 'GET',
        success: handleApiCallSuccess,
        error: handleApiCallError
      });
    }

    function handleApiCallSuccess (result) {
      var $xml = $(result);
      var response = parseInt($xml.find('checkEligibility').attr('responseType'), 10);

      if (response === CODE_AGENTS_UNAVAILABLE) { handleAdvisersUnavailable(); }
      if (response === CODE_AGENTS_BUSY) { handleAdvisersBusy(); }
      if (response === CODE_AGENTS_AVAILABLE) { handleAdvisersAvailable(); }
    }

    function handleApiCallError () {
      pollingEnabled = false;
      handleAdvisersUnavailable();

      GOVUK.analytics.trackEvent('webchat', 'error');
    }

    function handleOpenChat (evt) {
      evt.preventDefault();
      var url = OPEN_CHAT_URL(entryPointID);
      windowOpen(url, 'newwin', 'width=200,height=100');

      GOVUK.analytics.trackEvent('webchat', 'accepted');
    }

    function handleAdvisersUnavailable () {
      $advisersUnavailable.removeClass('hidden');

      $advisersBusy.addClass('hidden');
      $advisersAvailable.addClass('hidden');

      GOVUK.analytics.trackEvent('webchat', 'unavailable');
    }

    function handleAdvisersBusy () {
      $advisersBusy.removeClass('hidden');

      $advisersUnavailable.addClass('hidden');
      $advisersAvailable.addClass('hidden');

      GOVUK.analytics.trackEvent('webchat', 'busy');
    }

    function handleAdvisersAvailable () {
      $advisersAvailable.removeClass('hidden');

      $advisersUnavailable.addClass('hidden');
      $advisersBusy.addClass('hidden');

      GOVUK.analytics.trackEvent('webchat', 'offered');
    }
  }

  GOVUK.Webchat = Webchat;
})(window);
