$(function() {
  var projects_ctx = $("#projects");

  data = {
    datasets: [{
      data: [10, 20, 30],
      backgroundColor: [
        'rgba(255, 99, 132, 0.2)',
        'rgba(54, 162, 235, 0.2)',
        'rgba(255, 206, 86, 0.2)'
      ]
    }],

    // These labels appear in the legend and in the tooltips when hovering different arcs
    labels: [
      'Red',
      'Blue',
      'Yellow'
    ]
  };

  var projectsPieChart = new Chart(projects_ctx,{
    type: 'doughnut',
    data: data
  });
});
