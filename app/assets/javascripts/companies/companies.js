window.Companies = {
  filter: function(q, url, target) {
    var query = jQuery(q).val();

    jQuery.ajax({
      url: url,
      data: { q: query },
      type: "GET",
      dataType: "html",
      success: function (data) {
        jQuery(target).html(data);
      },
      error: function (xhr, status) {
          alert("Sorry, there was a problem!");
      },
      complete: function (xhr, status) {
          //$('#showresults').slideDown('slow')
      }
    });
  }
}

jQuery(document).ready(function() {
  jQuery("#member_search").keyup(function() {
    var url = document.location.href.replace("edit", "filter_available_members");

    Companies.filter("#member_search", url, "#available_members");
  });

  jQuery("#project_search").keyup(function() {
    var url = document.location.href.replace("edit", "filter_available_projects");

    Companies.filter("#project_search", url, "#available_projects");
  });
});
