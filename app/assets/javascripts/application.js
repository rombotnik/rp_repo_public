// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require cocoon
//= require tether
//= require bootstrap
//= require highcharts/highcharts
//= require datatables.min.js
//= require datatables.bootstrap4.min.js
//= require trix
//= require_tree .

var dataTable;

$(document).on('turbolinks:load', function(){

  // Bootstrap dismissable alerts
  $('.alert').alert();

  // jQuery datatables
  var $dataTable = $('.js-dataTable');
  if ($dataTable) {
    dataTable = $dataTable.DataTable({
      'order': [0, 'desc'],
      'columnDefs': [
        { 'width':'150px', 'targets': [0] },
        { 'width':'90px', 'targets': [-1] },
        { 'orderable': false, 'targets': [-1] }
      ]
    });
  }
});

// Bugfix for datatables duplicating wrapper on clicking back button
$(document).on('turbolinks:before-cache', function(){
  if ($('.dataTables_wrapper').length > 0) {
    dataTable.destroy();
  }
});
