$(document).on('ready page:load', function() {
  var data_chart = $("#hcontainer").data("chart");
  Highcharts.chart('hcontainer', {
    chart: {
      type: 'column'
    },
    title: {
      text: I18n.t('chart')
    },
    yAxis: {
      min: 0,
      title: {
        text: I18n.t('order')
      }
    },
    plotOptions: {
      column: {
        pointPadding: 0.2,
        borderWidth: 0
      }
    },
    series: [{
      name: I18n.t('product'),
      data: data_chart,
      dataLabels: {
        enabled: true,
        color: '#FFFFFF',
        align: 'center',
        format: '{point.y:.1f}',
        style: {
          fontSize: '16px',
          fontFamily: 'Verdana, sans-serif'
        }
      }
    }]
  });
})
